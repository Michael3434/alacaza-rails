class ChannelsController < ApplicationController
	def create
		@building = Building.find(params[:building_id])
		if @channel = Channel.create(channel_params)
			current_user.channels << @channel
			User.find(channel_params[:recipient_id]).channels << @channel
		else
			redirect_to appartments_path(@building.slug)
			return
		end
		redirect_to appartments_path(@building.slug, @channel)
	end

  def custom_channel
    channel = Channel.create(
        description: params[:channel][:description],
        created_by: current_user.id,
        channel_type: 'group',
        building_id: current_user.building_id,
        name: channel_params[:name])
    current_user.channels << channel
    params[:channel][:users_id].each do |user_id|
      next user_id if !user_id.present?
      User.find(user_id).channels << channel
      Mailer::UserMailerWorker.perform_async(:new_channel_invitation, user_id: user_id, channel_id: channel.id)
    end
    redirect_to appartments_path(current_user.building.slug, channel)
  end

  def edit_custom_channel
    channel = Channel.find(params[:channel_id])
    params[:channel][:users_id].each do |user_id|
      next user_id if !user_id.present?
      User.find(user_id).channels << channel
      Mailer::UserMailerWorker.perform_async(:new_channel_invitation, user_id: user_id, channel_id: channel.id)
    end
    redirect_to appartments_path(current_user.building.slug, channel)
  end

	def show

	end

	private

	def channel_params
		 params.require(:channel).permit(:recipient_id, :channel_type, :building_id, :users_id, :created_by, :name, :description)
	end
end
