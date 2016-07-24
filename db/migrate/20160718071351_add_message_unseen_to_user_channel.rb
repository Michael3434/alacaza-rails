class AddMessageUnseenToUserChannel < ActiveRecord::Migration
  def change
    add_column :user_channels, :messages_seen, :integer
  end
end
