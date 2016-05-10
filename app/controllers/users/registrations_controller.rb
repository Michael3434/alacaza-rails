class Users::RegistrationsController < Devise::RegistrationsController
  after_action :notify_new_user, on: :create

  respond_to :json, :js

  def after_sign_up_path_for(resource)
    if @user
      appartment_path(Building.find(@user.building_id).slug)
    end
  end

  private

  def notify_new_user
    if current_user
      # Notifier.new_user(current_user)
      UserMailer.welcome(current_user).deliver_now!
    end
  end
end
