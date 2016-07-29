class Admin::BuildingsController < AdminController
  def show
    @building = Building.where(slug: params[:slug]).last
    @channel = Channel.find_by_id(params[:channel])
    if @building.nil? && @channel.nil?
      render status: :not_found, text: "Not Found."
    end
    unless Rails.env == "development"
      # SlackNotifierWorker.perform_async(:new_message_page_view, user_id: current_user.id)
    end
    @messages = @channel.messages.includes(:user) if @channel
  end

  def index
    @buildings = Building.all
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(building_params)
    if @building.save
      redirect_to admin_buildings_path
    else
      render "new"
    end
  end

  def building_params
    params.require(:building).permit(:slug, :address, :building_access, :name)
  end
end
