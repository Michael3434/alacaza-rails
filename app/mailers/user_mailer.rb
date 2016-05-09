class UserMailer < ActionMailer::Base

  default from: "Cohome <hello@alacaza.fr>"

  def welcome(user)
    @user = user
    mail from: "Michael <hello@alacaza.fr>", to: @user.email, subject: "Bienvenue sur Cohome!"
  end

end
