class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = User.first
    UserMailer.welcome(user)
  end

  def new_message
    m = Message.first
    UserMailer.new_message(m, User.first)
  end

  def invitation
    UserMailer.invitation(Invitation.last)
  end
end
