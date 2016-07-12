class Gardien::MessagesController <  GardienController

  def colis_notifier
  end

  def notify_users
  end

  def user_notifier
  end

  def message_notifier
  end

  def notify_buildings
    params[:recipients_buildings].reject(&:empty?).each do |building|
      channel = Channel.where(building: building, channel_type: "main_group").last
      user = User.find_by_email("hello@alacaza.fr")
      @message = Message.create(user: user, building_id: building, channel_id: channel.id, body: params[:body])
      notifier(@message)
    end
    redirect_to admin_messages_path
  end

  def notifier(message)
    # if Rails.env != "development"
      User.all.where.not(id: @message.user.id).joins(:user_channels).where(user_channels: {channel_id: @message.channel_id }).each do |user|
        Mailer::UserMailerWorker.perform_async(:new_message, message_id: @message.id, user_id: user.id)
      end
      SlackNotifierWorker.perform_async(:new_message, message_id: @message.id)
    # end
  end

  private

  def message_params
    params.require(:message).permit(:body, :channel_id, :building_id, :user_id)
  end
end
