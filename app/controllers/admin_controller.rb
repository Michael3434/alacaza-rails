class AdminController < ActionController::Base
  before_action :authenticate_admin!
  private

  def authenticate_admin!
    authenticate_user!
    if !current_user.admin
      redirect_to root_url
      return
    end
  end
end
