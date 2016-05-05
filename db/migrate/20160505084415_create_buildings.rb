class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :password
      t.string :address
      t.string :slug

      t.timestamps null: false
    end
  end
end
