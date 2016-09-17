class Message < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  belongs_to :building
  belongs_to :channel
  has_many :comments, dependent: :destroy
  has_many :attachments, as: :attachable

  validate :file_size, if: "photo"

  serialize :users_like_id, Array
  serialize :vote_for_option_1, Array
  serialize :vote_for_option_2, Array
  serialize :vote_for_option_3, Array
  serialize :vote_for_option_4, Array
  serialize :vote_for_option_5, Array


  def file_size
    return true if !photo.file || self.persisted?
    if photo.file.size.to_f/(1000*1000) > 10
      errors.add(:photo_size, "Votre ficher dépasse les 10Mo")
    end
  end

  def tag_as_seen_by(user)
    seen_by << user.id
    save
  end

  def options
    options = []
    options << ["option_1", option_1] if option_1.present?
    options << ["option_2", option_2] if option_2.present?
    options << ["option_3", option_3] if option_3.present?
    options << ["option_4", option_4] if option_4.present?
    options << ["option_5", option_5] if option_5.present?
    options
  end

  def clean_vote(id)
    self.vote_for_option_1 = self.vote_for_option_1 - [id] if self.vote_for_option_1
    self.vote_for_option_2 = self.vote_for_option_2 - [id] if self.vote_for_option_2
    self.vote_for_option_3 = self.vote_for_option_3 - [id] if self.vote_for_option_3
  end

  def vote_count(option_id)
    self.send("vote_for_#{option_id}").length
  end

  def users_vote(option_id)
    User.where(id: self.send("vote_for_#{option_id}")).map(&:name).join(" / ")
  end
end
