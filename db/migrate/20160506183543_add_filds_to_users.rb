class AddFildsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :building_access, :string
  end
end
