class RenameColumnInPost < ActiveRecord::Migration
  def change
    rename_column :posts, :tag, :tags
    change_column :posts, :published, :boolean, default: true
  end
end
