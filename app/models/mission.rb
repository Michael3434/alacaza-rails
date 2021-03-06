class Mission < ActiveRecord::Base
  belongs_to :user
  has_one :building, through: :user

  validates :title, :category, :description, presence: true

  after_create :notify_users

  # This will notify all users of service who match the same category of the mission
  # It will also send an email the mission owner to inform him who is available to help him
  def notify_users
    Service.same_district_of(self.user).where(category: self.category).where.not(user: self.user).each do |service|
      Mailer::UserMailerWorker.perform_in(3.seconds, :new_mission_posted, mission_id: self.id, user_id: service.user.id)
    end
    Mailer::UserMailerWorker.perform_in(3.seconds, :people_availble_to_help, mission_id: self.id)
  end

  def self.same_district_of(user)
    joins(:user)
    .joins(:building)
    .where('buildings.district = ?', user.building.district)
  end
end
