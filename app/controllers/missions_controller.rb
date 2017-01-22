class MissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:edit, :update]
  before_action :get_variables

  def create
    @mission = Mission.new(mission_params.merge(user: current_user))
    @building = current_user.building
    if @mission.save
      SlackNotifierWorker.perform_async(:new_mission, mission_id: @mission.id)
      redirect_to users_account_path
    else
      render 'new'
    end
  end

  def show
    @mission = Mission.find(params[:id])
    @building = current_user.building
  end

  def edit
    @mission = Mission.find(params[:id])
    @building = current_user.building
  end

  def index
    @building = current_user.building
    @missions = Mission.same_district_of(current_user).order('missions.created_at desc').includes(:user)
  end

  def destroy
    @mission = Mission.find(params[:id])
    @mission.delete
    redirect_to :back
  end

  def update
    @mission = Mission.find(params[:id])
    @building = current_user.building
    if @mission.update(mission_params)
      redirect_to users_account_path
    else
      render 'new'
    end
  end

  def new
    @mission = Mission.new
    @building = current_user.building
  end

  def add_message
    mission_user = Mission.find(params[:mission_id]).user
    if channel = current_user.private_channel_with(mission_user)
      message = Message.create(body: params[:body], channel: channel, user: current_user, building_id: current_user.building.id)
    else
      channel = Channel.create(building: mission_user.building, channel_type: "private")
      message = Message.create(body: params[:body], channel: channel, user: current_user, building_id: current_user.building.id)
      current_user.channels << channel
      mission_user.channels << channel
    end

    Mailer::UserMailerWorker.perform_async(:new_message, message_id: message.id, user_id: mission_user.id)
    SlackNotifierWorker.perform_async(:new_message, message_id: message.id)

    redirect_to appartments_path(current_user.building.slug, channel)
  end


  private

  def authorize_user!
    mission = Mission.find(params[:id])
    unless mission.user == current_user
      redirect_to missions_path
    end
  end

  def get_variables
    @group_channels = current_user.all_group_channels.preload(:messages, :user_channels)
    @private_channels = current_user.private_channels.preload(:messages, :user_channels, :users)
  end

  def mission_params
    params.require(:mission).permit(
      :description,
      :title,
      :price,
      :category,
      :user_id)
  end

end
