class AddChannelTypeToChannels < ActiveRecord::Migration
  def change
  	add_column :channels, :channel_type, :string
  end
end
