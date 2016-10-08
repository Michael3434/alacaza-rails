class AddPrivateChannelIdsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private_channel_ids, :text
  end
end
