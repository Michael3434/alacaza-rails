class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:edit, :update]
  before_action :get_variables

  def create
    @item = Item.new(item_params.merge(user: current_user))
    if @item.save
      SlackNotifierWorker.perform_async(:item_created, item_id: @item.id)
      redirect_to users_account_path
    else
      @building = current_user.building
      render 'new'
    end
  end

  def index
    @building = current_user.building
    @items = Item.ongoing.same_district_of(current_user).order('items.created_at desc').includes(:user).page(params[:page] || 1).per(20)
  end

  def new
    @item = Item.new
    @building = current_user.building
  end

  def show
    @item = Item.find(params[:id])
    @other_items = @item.user.items.ongoing.where.not(id: @item.id)
    @building = current_user.building
  end

  def edit
    @item = Item.find(params[:id])
    @building = current_user.building
    unless @item.user == current_user
      redirect_to items_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to users_account_path
    else
      @building = current_user.building
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    SlackNotifierWorker.perform_async(:item_destroyed, item_id: @item.id)
    @item.delete
    redirect_to :back
  end

  def add_message
    item_user = Item.find(params[:id]).user
    if channel = current_user.private_channel_with(item_user)
      message = Message.create(body: params[:body], channel: channel, user: current_user, building_id: current_user.building.id)
    else
      channel = Channel.create(building: item_user.building, channel_type: "private")
      message = Message.create(body: params[:body], channel: channel, user: current_user, building_id: current_user.building.id)
      current_user.channels << channel
      item_user.channels << channel
    end

    Mailer::UserMailerWorker.perform_async(:new_message, message_id: message.id, user_id: item_user.id)
    SlackNotifierWorker.perform_async(:new_message, message_id: message.id)

    redirect_to appartments_path(current_user.building.slug, channel)
  end

  private

  def authorize_user!
    item = Item.find(params[:id])
    unless item.user == current_user
      redirect_to items_path
    end
  end

  def get_variables
    @group_channels = current_user.all_group_channels.preload(:messages, :user_channels)
    @private_channels = current_user.private_channels.preload(:messages, :user_channels, :users)
  end

  def item_params
    params.require(:item).permit(:description, :title, :price, :location, :sold, :photo, :category)
  end

end
