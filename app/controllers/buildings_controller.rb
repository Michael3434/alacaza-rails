class BuildingsController < ApplicationController
  before_action :sign_in_user_from_token, only: [:show]
  before_action :authenticate_user!

  def index

  end

  def show
    @building = Building.where(slug: params[:slug]).last
    @channel = Channel.find_by_id(params[:channel])
    if @building.nil? && @channel.nil?
      render status: :not_found, text: "Not Found."
    elsif @building && user_belongs_to_building?(@building) && @channel.nil?
      @channel = Channel.where(building_id: @building.id, channel_type: "main_group").last
      redirect_to appartments_path(@building.slug, @channel)
    elsif !user_belongs_to_building?(@building) || !UserChannel.where(user: current_user, channel: @channel).first
      redirect_to root_path
    end
    unless Rails.env == "development"
      SlackNotifierWorker.perform_async(:new_message_page_view, user_id: current_user.id)
    end
    @messages = @channel.messages.includes(:user) if @channel
  end

  private

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

  def user_belongs_to_building?(building)
    building.id == current_user.building_id
  end
end
