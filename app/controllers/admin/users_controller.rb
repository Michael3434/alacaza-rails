class Admin::UsersController < AdminController
  def index
    @users = User.search(params).preload(:building).order('id desc')
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      respond_to do |format|
        format.js
        format.html { redirect_to [:admin, @user]}
      end
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :company, :building_id)
  end
end

