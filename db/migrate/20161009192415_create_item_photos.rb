class CreateItemPhotos < ActiveRecord::Migration
  def change
    create_table :item_photos do |t|
      t.references :item, index: true, foreign_key: true
      t.string :photo

      t.timestamps null: false
    end
  end
end
