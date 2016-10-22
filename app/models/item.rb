class Item < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :user

  def self.ongoing
    where(sold: nil)
  end

  def self.sold
    where(sold: true)
  end

  def sold!
    self.sold = true
    self.save
  end

  def resell!
    self.sold = nil
    self.save
  end
end
