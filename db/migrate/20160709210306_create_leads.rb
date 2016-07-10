class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.string :code
      t.string :address
      t.string :floor
      t.string :door
      t.text :command

      t.timestamps null: false
    end
  end
end
