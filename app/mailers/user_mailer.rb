class UserMailer < ActionMailer::Base
  add_template_helper MailersHelper

  default from: "Cohome <hello@alacaza.fr>"

  def welcome(user)
    @user = user
    mail from: "Michael <hello@alacaza.fr>", to: @user.email, subject: "Bienvenue sur Alacaza!"
  end

  def new_message(message, user)
    @user = user
    @message = message

     mail from: "Michael <hello@alacaza.fr>", to: @user.email, subject: "Nouveau message sur la messagerie de votre immeuble !"
  end

end
