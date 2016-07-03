
namespace :data do
  task update_channels: :environment do
  	Building.all.each do |building|
  		channel = Channel.create(building: building, name: "Tout l'immeuble", channel_type: "main_group")
  		User.where(building: building).each do |user|
  			UserChannel.create!(channel: channel, user: user)
  		end
  		Message.where(building: building).update_all(channel_id: channel.id)
  	end
   end

  task send_new_message: :environment do
    body = "Nouveauté : Vous pouvez désormais envoyer des messages privés à vos voisins. Pour envoyer un message privé, cliquez directement sur le nom de l’interlocuteur. N’hésitez pas à nous envoyer en message privé les idées de fonctionnalités qui vous intéressent le plus. Merci pour vos suggestions. Nous restons à votre écoute et à votre service. L’équipe Alacaza."
    Channel.where(channel_type: "main_group").each do |channel|
      message = Message.create(body: body, channel_id: channel.id, user: User.first, building: channel.building)
      User.all.where.not(id: message.user.id).joins(:user_channels).where(user_channels: {channel_id: message.channel_id }).each do |user|
        Mailer::UserMailerWorker.perform_async(:new_message, message_id: message.id, user_id: user.id)
      end
    end
  end
end
