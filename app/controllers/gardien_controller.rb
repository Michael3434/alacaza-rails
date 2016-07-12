class GardienController < ActionController::Base
  before_action :authenticate_gardien!
  private

  def authenticate_gardien!
    authenticate_user!
    if !current_user.gardien
      redirect_to root_url
      return
    end
  end
end
