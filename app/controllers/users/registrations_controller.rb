class Users::RegistrationsController < Devise::RegistrationsController
  after_action :notify_new_user, on: :create
  after_action :add_building_slug_to_JSON, on: :create

  respond_to :json, :js

  private

  def add_building_slug_to_JSON
    return if @user.building_id.nil? || response.body.include?("You are being") || response.body.include?("!DOCTYPE html")
    body = JSON.parse(response.body)
    body[:building_slug] = Building.find(@user.building_id).slug
    response.body = body.to_json
  end

  def notify_new_user
    if current_user
      SlackNotifierWorker.perform_async(:new_user, user_id: current_user.id)
      Mailer::UserMailerWorker.perform_async(:welcome, user_id: current_user.id)
      channel = Channel.where(building_id: current_user.building.id, channel_type: "main_group").last
      Message.new(building: current_user.building, user: current_user, body: "#{current_user.first_name} a rejoint la messagerie de l'immeuble !", channel_id: channel.id).save
    end
  end

  def after_sign_up_path_for(resource)
    appartments_path(@user.building.slug)
  end
end
