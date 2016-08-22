class UserChannelsController < ApplicationController
  def update
    user_channel = UserChannel.find(params[:id])
    user_channel.update(user_channel_params)
  end

  def user_channel_params
     params.require(:user_channel).permit(:want_notification)
  end
end