class GardienController < ActionController::Base
  before_action :sign_in_user_from_token, only: [:show]
  before_action :authenticate_gardien!
  private

  def authenticate_gardien!
    authenticate_user!
    if !current_user.gardien
      redirect_to root_url
      return
    end
  end

  def sign_in_user_from_token
    token = params[:token].presence
    # If user is already signed in and no token is passed, there is nothing to do
    # If user is signed in but a token is passed, it could be for another user
    return if user_signed_in? && token.nil?

    user = token && User.find_by_token(token)
    if user && !user_signed_in?
      sign_in user
    elsif user && user_signed_in? && current_user == user
      return
    elsif user && user_signed_in? && current_user != user
      sign_out(current_user)
      sign_in(user)
    else
    end
  end

end
