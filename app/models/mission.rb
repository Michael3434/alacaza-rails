class Mission < ActiveRecord::Base
  belongs_to :user

  validates :title, :category, :description, presence: true

  after_create :notify_user

  # This will notify all users of service who match the same category of the mission
  def notify_user
    Service.where(category: self.category).each do |service|
      Mailer::UserMailerWorker.perform_async(:new_mission_posted, mission_id: self.id, user_id: service.user.id)
    end
  end
end
