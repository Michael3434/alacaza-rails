class ApplicationController < ActionController::Base
  before_action :sign_in_user_from_token
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :store_previous_url
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

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
    elsif invitation = Invitation.find_by_invitee_token(params[:token])
      if user = User.find_by_email(invitation.invitee_email)
        sign_in(user)
      else
        redirect_to new_user_registration_path(
          invitee_email: invitation.invitee_email,
          building_id: invitation.building.id,
          building_access: invitation.building.building_access)
      end
    else
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :first_name, :last_name, :building_id, :building_access, :floor, :door) }
  end

  def store_previous_url
    # store last url - this is needed for post-login redirect
    return unless request.get?
    if !request.path.match(/sign_up|sign_in|sign_out|password/) &&
       !request.xhr?
      session[:previous_url] = request.fullpath
    end
  end

end
