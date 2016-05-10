class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = User.first
    UserMailer.welcome(user)
  end

  def new_message
    m = Message.first
    UserMailer.new_message(m)
  end
end
