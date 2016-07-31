class AdminController < ActionController::Base
  before_action :authenticate_admin!
  private
  helper_method :sort_column, :sort_direction

  def authenticate_admin!
    authenticate_user!
    if !current_user.admin
      redirect_to root_url
      return
    end
  end

  def sort_column
    params[:sort] ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction].to_sym : :desc
  end
end
