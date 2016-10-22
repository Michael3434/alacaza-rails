class Users::ItemsController < ApplicationController
  def index
    @items = current_user.items
    @post = current_user.posts.last || Post.new
    @building = current_user.building
  end

  def sold
    @item = Item.find(params[:id])
    @item.sold!
    redirect_to :back
  end

  def resell
    @item = Item.find(params[:id])
    @item.resell!
    redirect_to :back
  end
end
