class AddFieldToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :created_by, :integer
  end
end
