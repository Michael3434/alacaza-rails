class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :attachable_type, null: false
      t.integer :attachable_id, null: false

      t.attachment :document

      t.boolean :is_deleted, default: false, null: false

      t.timestamps

      # Add index for polymorphic association
      t.index :attachable_type
      t.index :attachable_id
    end
  end
end
