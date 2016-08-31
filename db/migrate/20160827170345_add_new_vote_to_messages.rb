class AddNewVoteToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :as_vote_option, :boolean
    add_column :messages, :option_1, :string
    add_column :messages, :option_2, :string
    add_column :messages, :option_3, :string
    add_column :messages, :vote_for_option_1, :text
    add_column :messages, :vote_for_option_2, :text
    add_column :messages, :vote_for_option_3, :text
  end
end
