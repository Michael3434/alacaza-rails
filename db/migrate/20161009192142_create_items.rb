class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.boolean :sold
      t.string :category
      t.string :title
      t.text :description
      t.float :price
      t.string :location
      t.string :photo
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
