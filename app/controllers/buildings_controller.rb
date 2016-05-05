class BuildingsController < ApplicationController
  def index

  end

  def show
    @buidling = Building.where(slug: params[:slug]).last
    if @buidling.nil?
      render status: :not_found, text: "Not Found."
      return
    end
    @messages = @buidling.messages
  end
end
