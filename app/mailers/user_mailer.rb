class UserMailer < ActionMailer::Base
  add_template_helper MailersHelper

  default from: "Cohome <hello@alacaza.fr>"

  def welcome(user)
    @user = user
    mail from: "Michael <hello@alacaza.fr>", to: @user.email, subject: "Bienvenue sur Alacaza!"
  end

  def new_message(message)
    @user = message.user
    @message = message
    users_email = User.where(building_id: Message.first.building_id).pluck(:email)

     mail from: "Michael <hello@alacaza.fr>", to: users_email, subject: "Nouveau message sur la messagerie de votre immeuble !"
  end

end
