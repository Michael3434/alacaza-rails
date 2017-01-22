class Item < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_one :building, through: :user

  validates :photo, :title, :category, :price, presence: true

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

  def self.same_district_of(user)
    joins(:user)
    .joins(:building)
    .where('buildings.district = ?', user.building.district)
  end

end
