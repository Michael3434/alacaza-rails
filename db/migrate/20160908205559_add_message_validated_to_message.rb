class AddMessageValidatedToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :validated, :boolean, default: true
  end
end
