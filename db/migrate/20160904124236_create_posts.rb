class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :description
      t.string :title
      t.text :tag
      t.boolean :published
      t.string :availability
      t.float :price
      t.string :mobile_phone
      t.boolean :show_mobile_phone
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
