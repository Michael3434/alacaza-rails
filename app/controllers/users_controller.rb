class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @user = User.new
  end


  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      p @user.photo_changed?
      p "-==============================================="
      respond_to do |format|
        format.js
      end
    else
      @error = current_user.errors
      flash.now[:error] = "Vos modifications n'ont pas pu être enregistrées."
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
