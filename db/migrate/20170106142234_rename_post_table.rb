class RenamePostTable < ActiveRecord::Migration
  def change
    rename_table :posts, :services
    rename_column :services, :tags, :category
    change_column :services, :category, :string
    remove_column :services, :published
    remove_column :services, :availability
  end
end
