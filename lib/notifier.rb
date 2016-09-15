module Notifier
  class << self
    include Rails.application.routes.url_helpers
    def default_url_options
      ActionMailer::Base.default_url_options
    end

    def new_user(user)
      building_name = user.building.name
      message = "Sign Up -> Prénom: #{user.first_name} | Nom: #{user.last_name} | Email: #{user.email} | Building: #{building_name} | Etage: #{user.floor} | Numéro d'appartement: #{user.door}"
      notify(message)
    end

    def new_message_page_view(user)
      building_name = user.building.name
      message = "User -> #{user.email} de l'immeuble #{building_name} est sur la messagerie"
      notify(message)
    end

    def new_message(new_message)
      user = new_message.user
      message = "#{user.first_name} du bâtiment #{user.building.name} a laissé un message : #{new_message.body}"
      notify(message, { channel: "#messages" })
    end

    def new_message_from_gardien(new_message)
      user = new_message.user
      message = "#{user.first_name} du bâtiment #{user.building.name} a laissé un message : #{new_message.body}"
      notify(message, { channel: "#gardien" })
    end

    def new_comment(new_comment)
      user = new_comment.user
      message = "#{user.first_name} du bâtiment #{user.building.name} a laissé un commentaire : #{new_comment.body}"
      notify(message, { channel: "#messages" })
    end

    def new_like(the_message, user)
      message = "#{user.first_name} du bâtiment #{user.building.name} a liké: #{the_message.body}"
      notify(message, { channel: "#likes" })
    end

    def new_lead(lead)
      message = "Nouvelle commande"
      options = {
        channel: "#pizzas",
        attachments: [
          { title: "Prénom", text: lead.first_name },
          { title: "Nom", text: lead.last_name },
          { title: "Téléphone", text: lead.phone },
          { title: "Adresse", text: lead.address },
          { title: "Etage et porte", text: lead.floor },
          { title: "Code", text: lead.code },
          { title: "La commande", text: lead.command }
        ]
      }
      notify(message, options)
    end

    def new_post(post)
      message = "Nouveau post"
      options = {
        channel: "#website",
        attachments: [
          { title: "Prénom", text: post.user.first_name },
          { title: "Nom", text: post.user.last_name },
          { title: "Titre", text: post.title },
          { title: "Description", text: post.description }
        ]
      }
      notify(message, options)
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
