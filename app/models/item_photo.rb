class ItemPhoto < ActiveRecord::Base
  belongs_to :item
  mount_uploader :photo, PhotoUploader

  #
  # Comparable
  #

  def <=>(other)
    position <=> other.position
  end
end
