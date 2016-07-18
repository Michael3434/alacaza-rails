class Gardien::MessagesController <  GardienController
  before_action :authenticate_user!

  def notify_message
  end

  def notify_users
    params[:users_id].reject(&:empty?).each do |user_id|
      user = User.find(user_id)
      # current_user << Is the gardien
      # Look first if there is already a conversation between gardien and user
      # If not, create a new one and then create the message
      if channel = current_user.private_channel_with(user)
      else
        channel = Channel.create(building: user.building, channel_type: "private")
        current_user.channels << channel
        user.channels << channel
      end
      @message = Message.new(user: current_user, building_id: user.building.id, channel_id: channel.id, body: user.build_colis_message)
      if @message.save
        notifier_users(@message)
        flash[:success] = "Les messages ont bien été envoyés"
      else
         flash[:alert] = "Un problème est survenue, si le problème persiste, contactez Michael au 0768453300"
      end
    end
    redirect_to gardien_notify_colis_path
  end

  def notify_buildings
    params[:recipients_buildings].reject(&:empty?).each do |building|
      building = Building.find(building)
      channel = Channel.where(building: building, channel_type: "main_group").last
      user = User.find_by_email("hello@alacaza.fr")
      @message = Message.new(user: user, building_id: building.id, channel_id: channel.id, body: params[:body])
      if @message.save
        notifier_users(@message)
        flash[:success] = "Les messages ont bien été envoyés"
      else
        flash[:alert] = "Un problème est survenue, si le problème persiste, contactez Michael au 0768453300"
      end
    end
    redirect_to gardien_notify_message_path
  end

  def notifier_users(message)
    # if Rails.env != "development"
      User.all.where.not(id: @message.user.id).joins(:user_channels).where(user_channels: {channel_id: @message.channel_id }).each do |user|
        Mailer::UserMailerWorker.perform_async(:new_message, message_id: @message.id, user_id: user.id)
      end
      SlackNotifierWorker.perform_async(:new_message, message_id: @message.id)
    # end
  end

  def notify_user(message, user)
  end

  private

  def message_params
    params.require(:message).permit(:body, :channel_id, :building_id, :user_id)
  end

end
