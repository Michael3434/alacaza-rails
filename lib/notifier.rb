module Notifier
  class << self
    include Rails.application.routes.url_helpers
    def default_url_options
      ActionMailer::Base.default_url_options
    end

    def new_user(user)
      building_name = user.building.name
      message = "Sign Up -> Prénom: #{user.first_name} | Nom: #{user.last_name} | Email: #{user.email} | Building: #{building_name}"
      notify(message)
    end

    def new_message_page_view(user)
      building_name = user.building.name
      message = "User -> #{user.email} de l'immeuble #{building_name} est sur la messagerie"
      notify(message)
    end

    def new_message_sent(new_message)
      user = new_message.user
      message = "#{user.first_name} du bâtiment #{user.building.name} a laissé un message : #{new_message.body}"
      notify(message, { channel: "#messages" })
    end

    private

    def slack
      @slack ||= Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"], username: ENV["SLACK_WEBHOOK_USERNAME"], channel: "#website", icon_emoji: ":cocktail:"
    end

    def notify(message, options = {})
      if Rails.env.in?(["development", "staging"])
        options[:channel] = "@mike0mike"
      end

      begin
        slack.ping message, options
      end
    end
  end
end
