class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :building, index: true, foreign_key: true
      t.integer :invitee_id
      t.integer :inviter_id
      t.string :invitee_email
      t.string :invitee_token

      t.timestamps null: false
    end
  end
end
