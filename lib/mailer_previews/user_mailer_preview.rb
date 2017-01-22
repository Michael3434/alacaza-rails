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

  def people_availble_to_help
    UserMailer.people_availble_to_help(Mission.last)
  end

  def people_who_need_help
    UserMailer.people_who_need_help(Service.last)
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
