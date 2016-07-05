class AddOriginalFileNameToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :original_filename, :string
  end
end
