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

  def password_email(user, password)
    @user = user
    @password = password

    mail from: "Alacaza <hello@alacaza.fr>", to: @user.email, subject: "Alacaza - Votre mot de passe"
  end

  def welcome_with_password(user, password)
    @user = user
    @password = password

    mail from: "Alacaza <hello@alacaza.fr>", to: @user.email, subject: "Bienvenue sur Alacaza!"
  end

  def new_comment(comment, user)
    @user = user
    @comment = comment
    @message = @comment.message

     mail from: "Michael de Alacaza <hello@alacaza.fr>", to: @user.email, subject: "Nouveau commentaire sur la messagerie de votre immeuble !"
  end

end
