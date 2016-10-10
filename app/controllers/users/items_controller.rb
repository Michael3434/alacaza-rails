class Users::ItemsController < ApplicationController
  def index
    @items = current_user.items
    @post = current_user.posts.last || Post.new
    @building = current_user.building
  end
end
