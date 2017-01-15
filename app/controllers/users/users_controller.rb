class Users::UsersController < ApplicationController
  before_action :get_variables
  def account
  end

  def edit_account
  end

  def get_variables
    @group_channels = current_user.all_group_channels.preload(:messages, :user_channels)
    @private_channels = current_user.private_channels.preload(:messages, :user_channels, :users)
    @building = current_user.building
  end
end
