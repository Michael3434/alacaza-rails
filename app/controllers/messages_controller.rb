class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]
  def create
    @message = current_user.messages.build(message_params)
    @building_name = @message.user.building.name
    @building = @message.user.building
    if @message.save!
      message_notifier
    end
  end

  def message_notifier
    # if Rails.env != "development"
      User.all.where.not(id: @message.user.id).joins(:user_channels).where(user_channels: {channel_id: @message.channel_id }).each do |user|
        Mailer::UserMailerWorker.perform_async(:new_message, message_id: @message.id, user_id: user.id)
      end
      SlackNotifierWorker.perform_async(:new_message, message_id: @message.id)
    # end
  end

  private

  def message_params
    params.require(:message).permit(:body, :channel_id, :building_id)
  end
end
