class AddVotesToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :option_4, :string
    add_column :messages, :option_5, :string
    add_column :messages, :vote_for_option_4, :text
    add_column :messages, :vote_for_option_5, :text
  end
end
