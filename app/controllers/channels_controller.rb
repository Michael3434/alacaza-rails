class ChannelsController < ApplicationController
	def create
		@buidling = Building.find(params[:building_id])
		@channel = Channel.create(name: "private", building_id: @buidling.id)
		current_user.channels << @channel
		User.find(channel_params[:recipient_id]).channels << @channel

		redirect_to appartments_path(@buidling.slug, @channel)
	end

	def show
		
	end

	private	

	def channel_params
		 params.require(:channel).permit(:recipient_id)
	end
end