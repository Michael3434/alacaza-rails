class ChangeNotificationInUserChannel < ActiveRecord::Migration
  def change
    change_column :user_channels, :want_notification, :boolean, default: :true
  end
end
