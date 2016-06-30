class Message < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  belongs_to :building
  belongs_to :channels
  has_many :comments, dependent: :destroy

  has_many :attachments, as: :attachable
end
