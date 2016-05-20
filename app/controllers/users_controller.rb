class UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
    @user = User.new
  end

  private

  def authenticate_admin!
    authenticate_user!
    if !current_user.is_admin?
      redirect_to root_url
      return
    end
  end
end
