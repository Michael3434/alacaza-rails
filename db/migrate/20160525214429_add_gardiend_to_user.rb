class AddGardiendToUser < ActiveRecord::Migration
  def change
    add_column :users, :gardien, :boolean, default: false
  end
end
