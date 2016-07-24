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

  def user_channel_with(user)
    user_channels.where(channel_id: id, user_id: user.id).last
  end

  def messages_unseen_by(user)
    messages.where.not(user_id: user.id).count - ( user_channel_with(user).messages_seen || 0)
  end

  def mark_as_seen_by(user)
    user_channel = user_channel_with(user)
    user_channel.update(messages_seen: messages.where.not(user_id: user.id).count)
  end

  def self.main_groups
    where(channel_type: "main_group")
  end
end
