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

    def new_channel(channel)
      user = User.find(channel.created_by)
      message = "Nouveau canal de discussion"
      options = {
        channel: "#website",
        attachments: [
          { title: "Crée par", text: "#{user.name} du bâtiment #{user.building.name}" },
          { title: "Name", text: channel.name },
          { title: "Descripion", text: channel.description }
        ]
      }
      notify(message, options)
    end

    def new_mission(mission)
      message = "Nouvelle mission"
      options = {
        channel: "#website",
        attachments: [
          { title: "Prénom", text: mission.user.first_name },
          { title: "Nom", text: mission.user.last_name },
          { title: "Immeuble", text: mission.user.building.name },
          { title: "Titre", text: mission.title },
          { title: "Description", text: mission.description }
        ]
      }
      notify(message, options)
    end

    def new_service(service)
      message = "Nouveau service"
      options = {
        channel: "#website",
        attachments: [
          { title: "Prénom", text: service.user.first_name },
          { title: "Nom", text: service.user.last_name },
          { title: "Immeuble", text: service.user.building.name },
          { title: "Titre", text: service.title },
          { title: "Description", text: service.description }
        ]
      }
      notify(message, options)
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

    def item_sold(item)
      message = "Object vendu"
      options = {
        channel: "#item",
        attachments: [
          { title: "Vendeur", text: "#{item.user.name} du bâtiment #{item.user.building.name}" },
          { title: "Objet", text: item.title },
          { title: "Prix", text: "#{item.price.round(0)}" }
        ]
      }
      notify(message, options)
    end

    def item_destroyed(item)
      message = "Object supprimé"
      options = {
        channel: "#item",
        attachments: [
          { title: "Vendeur", text: "#{item.user.name} du bâtiment #{item.user.building.name}" },
          { title: "Objet", text: item.title },
          { title: "Prix", text: "#{item.price.round(0)}" }
        ]
      }
      notify(message, options)
    end

    def item_created(item)
      message = "Nouvel objet en vente"
      options = {
        channel: "#item",
        attachments: [
          { title: "Vendeur", text: "#{item.user.name} du bâtiment #{item.user.building.name}" },
          { title: "Objet", text: item.title },
          { title: "Prix", text: "#{item.price.round(0)}" }
        ]
      }
      notify(message, options)
    end

    def new_like(the_message, user)
      message = "#{user.first_name} du bâtiment #{user.building.name} a liké: #{the_message.body}"
      notify(message, { channel: "#likes" })
    end

    def new_invitation(invitation)
      @invitation = invitation
      @inviter = invitation.inviter
      @building = invitation.building

      message = "#{@inviter.first_name} du bâtiment #{@building.name} a invité: #{@invitation.invitee_email}"
      notify(message, { channel: "#invitation" })
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
