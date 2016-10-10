class ItemsController < ApplicationController
  def create
    @item = Item.new(item_params.merge(user: current_user))
    if @item.save
      redirect_to users_items_path
    else
      render 'new'
    end
  end

  def new
    @item = Item.new
    @building = current_user.building
    @post = current_user.posts.last || Post.new
  end

  private

  def item_params
    params.require(:item).permit(:description, :title, :price, :location, :sold, :photo, :category)
  end

end
