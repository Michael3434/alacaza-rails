
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

  task asign_channel_to_pierre: :environment do
    user = User.find_by_email(ENV['PIERRE_EMAIL'])
    buildings_id = Building.where(slug: Building::PIERRE).pluck(:id)
    Channel.main_groups.where(building_id: buildings_id).each do |channel|
      if UserChannel.where(user_id: user.id, channel_id: channel.id).count > 0
        p "Already a user channel"
      else
        user.channels << channel
      end
    end
  end


  task asign_channel_to_admin: :environment do
    user = User.find_by_email("hello@alacaza.fr")
    Channel.main_groups.each do |channel|
      if UserChannel.where(user_id: user.id, channel_id: channel.id).count > 0
        p "Already a user channel"
      else
        user.channels << channel
      end
    end
  end
end
