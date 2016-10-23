class BuildingsController < ApplicationController
  before_action :sign_in_user_from_token, only: [:show]
  before_action :authenticate_user!

  def index
  end

  def show
    @user = current_user
    @building = Building.find_by_slug(params[:slug])
    @channel = Channel.find_by_id(params[:channel])
    if @building.nil? && @channel.nil?
      render status: :not_found, text: "Not Found."
    elsif current_user.admin
      @channel = @channel || Channel.where(building_id: @building.id, channel_type: "main_group").last
    elsif @channel.try(:channel_type) == "group" && UserChannel.where(user: current_user, channel: @channel).first
      true
    elsif @building && user_belongs_to_building?(@building) && @channel.nil?
      @channel = Channel.where(building_id: @building.id, channel_type: "main_group").last
      redirect_to appartments_path(@building.slug, @channel)
    elsif !user_belongs_to_building?(@building) || !UserChannel.where(user: current_user, channel: @channel).first
      redirect_to root_path
    end
    unless Rails.env == "development"
      # SlackNotifierWorker.perform_async(:new_message_page_view, user_id: current_user.id)
    end
    if @channel
      @post = current_user.posts.last || Post.new
      @messages = @channel.messages.order(created_at: :desc).includes(:user).page(params[:page] || 1).per(20).reverse
      @channel.mark_as_seen_by(current_user)
      @group_channels = current_user.all_group_channels.preload(:messages, :user_channels)
      @private_channels = current_user.private_channels.preload(:messages, :user_channels, :users)
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
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

  def user_belongs_to_building?(building)
    building.id == current_user.building_id
  end

end
