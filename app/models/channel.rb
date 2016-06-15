class Channel < ActiveRecord::Base
  belongs_to :building

  has_many :user_channels
  has_many :users, through: :user_channels

  attr_accessor :recipient_id
end
