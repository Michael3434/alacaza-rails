
namespace :data do
  task update_channels: :environment do
  	Building.all.each do |building|
  		channel = Channel.create(building: building, name: "Tout l'immeuble", channel_type: "main_group")
  		user = User.where(building: building).each do |user|
  			UserChannel.create!(channel: channel, user: user)
  		end
  		Message.where(building: building).update_all(channel_id: channel.id)
  	end
   end
end
