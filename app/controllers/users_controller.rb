class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @user = User.new
  end


  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      respond_to do |format|
        format.js
      end
    else
    end
  end

  def change_picture
    @user = User.find(current_user.id)
    if @user.update(user_params)
      respond_to do |format|
        format.js
      end
    else
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :image_id,
      :photo,
      :pseudo,
      :floor,
      :door,
      :age,
      :sex,
      :user_status)
  end
end
