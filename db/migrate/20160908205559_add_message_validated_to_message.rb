class AddMessageValidatedToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :validated, :boolean, default: true
  end
end


User.last(10).each do |user|
  a = user.user_channels.pluck(:channel_id)
  dup = (a.detect{ |e| a.count(e) > 1 }).try(:uniq)
  UserChannel.where(id: dup).destroy_all if dup
end

