class AddFieldsProfilToUser < ActiveRecord::Migration
  def change
    add_column :users, :age, :string
    add_column :users, :sex, :string
    add_column :users, :user_status, :string
    add_column :users, :photo, :string
  end
end
