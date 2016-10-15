class Channel < ActiveRecord::Base
  belongs_to :building

  has_many :user_channels, dependent: :destroy
  has_many :users, through: :user_channels
  has_many :messages, -> { where(validated: true) }, dependent: :destroy

  attr_accessor :recipient_id, :users_id, :all_building

  def private?
  	channel_type == "private"
  end

  def group?
  	channel_type.in?(["group",""])
  end

  def main_group?
    channel_type.in?(["main_group",""])
  end

  def user_channel_with(user)
    user_channels.select { |user_channel|
      user_channel.channel_id == id &&
      user_channel.user_id == user.id
    }.last
  end

  def messages_unseen_by(user)
    messages.select { |message| message.user_id != user.id }.length - ( user_channel_with(user).messages_seen || 0)
  end

  def mark_as_seen_by(user)
    user_channel = user_channel_with(user)
    if user_channel
      user_channel.update(messages_seen: messages.where.not(user_id: user.id).count)
    end
  end

  def services_for_docks?
    self == Channel.where(name: "Les services des Docks").last
  end

  def self.main_groups
    where(channel_type: "main_group")
  end
end
