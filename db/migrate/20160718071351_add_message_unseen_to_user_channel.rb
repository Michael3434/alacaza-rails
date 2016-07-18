class AddMessageUnseenToUserChannel < ActiveRecord::Migration
  def change
    add_column :user_channels, :messages_unseen, :integer
  end
end
