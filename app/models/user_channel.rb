class UserChannel < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  after_create :add_channel_id_to_user, if: "channel.channel_type == 'private'"
  after_destroy :destroy_channel_id_to_user, if: "channel.channel_type == 'private'"


  #
  # Callback
  #

  def add_channel_id_to_user
    user.private_channel_ids << channel.id
    user.save
  end

  def destroy_channel_id_to_user
    user.private_channel_ids.delete(channel.id)
    user.save
  end
end
