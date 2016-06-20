class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.references :building, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
