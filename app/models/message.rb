class Message < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  belongs_to :building
  belongs_to :channels
  has_many :comments, dependent: :destroy
  has_many :attachments, as: :attachable

  validate :file_size, if: "photo"

  def file_size
    return true unless photo.file
    if photo.file.size.to_f/(1000*1000) > 10
      errors.add(:photo_size, "Votre ficher dépasse les 10Mo")
    end
  end
end
