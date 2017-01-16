class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = User.first
    UserMailer.welcome(user)
  end

  def new_mission_posted
    UserMailer.new_mission_posted(Mission.last, User.last)
  end

  def new_service_posted
    UserMailer.new_service_posted(Service.last, User.last)
  end

  def new_message
    m = Message.first
    UserMailer.new_message(m, User.first)
  end

  def invitation
    UserMailer.invitation(Invitation.last)
  end

  def happy
    UserMailer.happy(User.last)
  end
end
