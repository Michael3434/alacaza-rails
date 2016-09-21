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

  end

	def show

	end

	private

	def channel_params
		 params.require(:channel).permit(:recipient_id, :channel_type, :building_id)
	end
end
