class Users::RegistrationsController < Devise::RegistrationsController
  after_action :notify_new_user, on: :create
  after_action :add_building_slug_to_JSON, on: :create

  respond_to :json, :js

  private

  def add_building_slug_to_JSON
    body = JSON.parse(response.body)
    body[:building_slug] = Building.find(@user.building_id).slug
    response.body = body.to_json
  end

  def notify_new_user
    if current_user
      Notifier.new_user(current_user) unless Rails.env.in?(["development"])
      UserMailer.welcome(current_user).deliver_now!
      Message.new(building: current_user.building, user: current_user, body: "#{current_user.first_name} a rejoint la messagerie de l'immeuble !" ).save
    end
  end
end
