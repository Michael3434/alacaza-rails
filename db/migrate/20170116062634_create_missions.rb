class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.text :description
      t.string :price
      t.string :category
      t.string :title
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
