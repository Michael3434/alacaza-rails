class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_variables
  def create
    @service = Service.new(service_params.merge(user: current_user))
    @building = current_user.building
    if @service.save
      SlackNotifierWorker.perform_async(:new_service, service_id: @service.id)
      redirect_to users_account_path
    else
      render 'new'
    end
  end

  def show
    @service = Service.find(params[:id])
    @building = current_user.building
  end

  def edit
    @service = Service.find(params[:id])
    @building = current_user.building
  end

  def index
    @building = current_user.building
    @services = Service.all
  end

  def destroy
    @service = Service.find(params[:id])
    @service.delete
    redirect_to :back
  end

  def update
    @service = Service.find(params[:id])
    @building = current_user.building
    if @service.update(service_params)
      redirect_to users_account_path
    else
      render 'new'
    end
  end

  def new
    @service = Service.new
    @building = current_user.building
  end

  def add_message
    service_user = Service.find(params[:service_id]).user
    if channel = current_user.private_channel_with(service_user)
      message = Message.create(body: params[:body], channel: channel, user: current_user, building_id: current_user.building.id)
    else
      channel = Channel.create(building: service_user.building, channel_type: "private")
      message = Message.create(body: params[:body], channel: channel, user: current_user, building_id: current_user.building.id)
      current_user.channels << channel
      service_user.channels << channel
    end

    Mailer::UserMailerWorker.perform_async(:new_message, message_id: message.id, user_id: service_user.id)
    SlackNotifierWorker.perform_async(:new_message, message_id: message.id)

    redirect_to appartments_path(current_user.building.slug, channel)
  end


  private

  def get_variables
    @group_channels = current_user.all_group_channels.preload(:messages, :user_channels)
    @private_channels = current_user.private_channels.preload(:messages, :user_channels, :users)
  end

  def service_params
    params.require(:service).permit(
      :description,
      :title,
      :price,
      :category,
      :user_id)
  end

end
