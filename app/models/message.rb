class Message < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  belongs_to :building
  belongs_to :channels
  has_many :comments, dependent: :destroy
  has_many :attachments, as: :attachable

  validate :file_size, if: "photo"

  serialize :users_like_id, Array

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
end
