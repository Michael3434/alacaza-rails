
namespace :data do

  task asign_channel_to_pierre: :environment do
    user = User.find_by_email(ENV['PIERRE'])
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
