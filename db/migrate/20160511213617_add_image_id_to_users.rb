class AddImageIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image_id, :integer
    add_column :users, :admin, :boolean, default: false
  end
end
