class ChangeDoorIntoString < ActiveRecord::Migration
  def change
    change_column :users, :door, :string
  end
end
