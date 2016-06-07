class BuildingsController < ApplicationController
  before_action :sign_in_user_from_token, only: [:show]
  before_action :authenticate_user!

  def index

  end

  def show
    @buidling = Building.where(slug: params[:slug]).last
    if @buidling.nil?
      render status: :not_found, text: "Not Found."
      return
    elsif @buidling.id != current_user.building_id
      redirect_to root_path
      return
    end
    SlackNotifierWorker.perform_async(:new_message_page_view, user_id: current_user.id)


    @messages = @buidling.messages
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
end
