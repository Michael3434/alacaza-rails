class Invitation < ActiveRecord::Base
  belongs_to :invitee, class_name: "User"
  belongs_to :inviter, class_name: "User"
  belongs_to :building

  before_create :set_invitation_token

  after_create :notify_invitee

  def set_invitation_token
    self.invitee_token = Digest::SHA1.hexdigest([Time.now, invitee_email, rand].join)
  end

  def notify_invitee
    Mailer::UserMailerWorker.perform_in(3.seconds, :invitation, invitation_id: id)
  end
end
