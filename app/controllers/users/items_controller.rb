class Users::ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_variables
  def index
    @items = current_user.items
    @post = current_user.posts.last || Post.new
    @building = current_user.building
  end

  def sold
    @item = Item.find(params[:id])
    @item.sold!
    SlackNotifierWorker.perform_async(:item_sold, item_id: @item.id)
    redirect_to :back
  end

  def resell
    @item = Item.find(params[:id])
    @item.resell!
    redirect_to :back
  end

  private

  def get_variables
    @group_channels = current_user.all_group_channels.preload(:messages, :user_channels)
    @private_channels = current_user.private_channels.preload(:messages, :user_channels, :users)
  end
end
