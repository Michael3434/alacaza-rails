class Channel < ActiveRecord::Base
  belongs_to :building

  has_many :user_channels, dependent: :destroy
  has_many :users, through: :user_channels
  has_many :messages, dependent: :destroy

  attr_accessor :recipient_id

  def private?
  	channel_type == "private"
  end

  def group?
  	channel_type.in?(["group","main_group"])
  end

  def self.main_groups
    where(channel_type: "main_group")
  end
end
