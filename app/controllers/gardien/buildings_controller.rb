class Gardien::BuildingsController < GardienController
  def show
    @user = current_user
    @building = Building.where(slug: params[:slug]).last
    @channel = Channel.find_by_id(params[:channel])
    if @building.nil? && @channel.nil?
      render status: :not_found, text: "Not Found."
    end
    unless Rails.env == "development"
      # SlackNotifierWorker.perform_async(:new_message_page_view, user_id: current_user.id)
    end
    @channel = @channel || Channel.where(building_id: @building.id, channel_type: "main_group").last
    @messages = @channel.messages.includes(:user) if @channel
    @channel.mark_as_seen_by(current_user)
  end
end
