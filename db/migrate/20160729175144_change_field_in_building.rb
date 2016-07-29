class ChangeFieldInBuilding < ActiveRecord::Migration
  def change
    rename_column :buildings, :password, :building_access
  end
end
