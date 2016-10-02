module ChannelsHelper
	def not_current_user(channel)
		channel.users.where.not(id: current_user.id).last
	end

	def get_current_channel(channel)
		if params[:channel] == channel.id.to_s
			"current"
		else
			"others"
		end
	end

  def user_channel(channel)
    current_user.user_channels.where(channel_id: channel.id).last
  end
end
