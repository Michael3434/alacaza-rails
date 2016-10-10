class Item < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :user

  def self.ongoing
    where(sold: nil)
  end

  def self.sold
    where(sold: true)
  end
end
