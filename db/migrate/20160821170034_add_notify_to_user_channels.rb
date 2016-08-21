class AddNotifyToUserChannels < ActiveRecord::Migration
  def change
    add_column :user_channels, :want_notification, :boolean, default: false
  end
end
