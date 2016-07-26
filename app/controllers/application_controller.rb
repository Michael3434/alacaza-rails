class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :store_previous_url
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

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
