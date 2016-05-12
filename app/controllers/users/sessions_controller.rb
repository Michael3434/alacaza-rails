class Users::SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token, only: [:destroy]
  after_action :add_building_slug_to_JSON, only: :create

  respond_to :json, :html

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def add_building_slug_to_JSON
    unless action_name == "destroy"
      if request.format.symbol == :html
        root_path
      else
        body = JSON.parse(response.body.to_json).first
        body[:building_slug] = Building.find(@user.building_id).slug
        response.body = body.to_json
      end
    end
  end
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
