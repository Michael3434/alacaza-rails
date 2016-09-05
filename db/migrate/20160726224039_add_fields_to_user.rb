class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :floor, :integer
    add_column :users, :door, :integer
  end
end
