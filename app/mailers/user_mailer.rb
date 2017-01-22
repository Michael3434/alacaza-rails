class UserMailer < ActionMailer::Base
  add_template_helper MailersHelper

  default from: "Alacaza <hello@alacaza.fr>"

  def welcome(user)
    @user = user
    mail from: "Michael de Alacaza <hello@alacaza.fr>", to: @user.email, subject: "Bienvenue sur Alacaza!"
  end

  def new_message(message, user)
    @user = user
    @message = message

     mail from: "Alacaza <hello@alacaza.fr>", to: @user.email, subject: "Re: Nouveau message sur la messagerie de votre immeuble !"
  end

  def people_availble_to_help(mission)
    @mission = mission
    @user = mission.user
    @services = Service.same_district_of(@user).where(category: mission.category).where.not(user: @user)

    mail from: "Alacaza <hello@alacaza.fr>", to: @user.email, subject: "Vous venez de poster une mission !"
  end

  def people_who_need_help(service)
    @service = service
    @user = service.user
    @missions = Mission.same_district_of(@user).where(category: service.category).where.not(user: @user)

    mail from: "Alacaza <hello@alacaza.fr>", to: @user.email, subject: "Vous venez de proposer vos services !"
  end

  def new_mission_posted(mission, user)
    @user = user
    @mission = mission

     mail from: "Alacaza <hello@alacaza.fr>", to: @user.email, subject: "#{@mission.user.pseudo} a besoin de vous !"
  end

  def new_service_posted(service, user)
    @user = user
    @service = service

     mail from: "Alacaza <hello@alacaza.fr>", to: @user.email, subject: "Quelqu'un peut vous aider !"
  end

  def invitation(invitation)
    @invitation = invitation
    @inviter = invitation.inviter
    @building = invitation.building

     mail from: "Alacaza <hello@alacaza.fr>", to: @invitation.invitee_email, subject: "Invitation à rejoindre la messagerie de votre immeuble"
  end

  def password_email(user, password)
    @user = user
    @password = password

    mail from: "Alacaza <hello@alacaza.fr>", to: @user.email, subject: "Alacaza - Votre mot de passe"
  end

  def welcome_with_password(user, password)
    @user = user
    @password = password

    mail from: "Alacaza <hello@alacaza.fr>", to: @user.email, bcc: "hello@alacaza.fr", subject: "Bienvenue sur Alacaza!"
  end

  def new_comment(comment, user)
    @user = user
    @comment = comment
    @message = @comment.message

     mail from: "Michael de Alacaza <hello@alacaza.fr>", to: @user.email, subject: "Nouveau commentaire sur la messagerie de votre immeuble !"
  end

  def new_channel_invitation(user, channel)
    @user = user
    @channel = channel
    @created_by = User.find(channel.created_by)

    mail from: "Alacaza <hello@alacaza.fr>", to: @user.email, subject: "#{@created_by.name} vous a ajouté au groupe #{@channel.name}"
  end

end
