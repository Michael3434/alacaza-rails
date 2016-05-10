class BuildingsController < ApplicationController
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
    end
    @messages = @buidling.messages
  end
end
