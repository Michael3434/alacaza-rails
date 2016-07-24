class AddLikesToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :users_like_id, :text
  end
end
