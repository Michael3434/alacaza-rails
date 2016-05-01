module Notifier
  class << self
    include Rails.application.routes.url_helpers
    def default_url_options
      ActionMailer::Base.default_url_options
    end

    def new_user(user)
      message = "Sign Up -> Prénom : #{user.first_name} | Nom : #{user.last_name} | Email : #{user.email} | Ville : #{user.city} "
      notify(message)
    end

    private

    def slack
      @slack ||= Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"], username: ENV["SLACK_WEBHOOK_USERNAME"], channel: "#website", icon_emoji: ":cocktail:"
    end

    def notify(message, options = {})
      if Rails.env.in?(["development", "staging"])
        options[:channel] = "#website"
      end

      begin
        slack.ping message, options
      end
    end
  end
end
