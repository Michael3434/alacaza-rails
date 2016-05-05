class Users::RegistrationsController < Devise::RegistrationsController
  after_action :notify_new_user, on: :create

  respond_to :json, :js

  private

  def notify_new_user
    if current_user
      # Notifier.new_user(current_user)
    end
  end
end
