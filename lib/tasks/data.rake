require 'csv'
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

  task add_new_users: :environment do
    CSV.foreach('db/users.csv', headers: true) do |row|
      password = "#{row["first_name"]}.#{rand(99999)}"
      user = User.new(
          first_name: row["first_name"],
          last_name: row["last_name"],
          email: row['email'],
          door: row["door"],
          password: password
          )
      if user.save!
        Mailer::UserMailerWorker.perform_async(:welcome_with_password, user_id: user.id, password)
      end
    end
  end

  task delete_extra_channels: :environment do
    User.all.each do |user|
      ids = user.user_channels.pluck(:channel_id)
      ids.each do |id|
        if UserChannel.where(user_id: user.id, channel_id: id).count > 1
          UserChannel.where(user_id: user.id, channel_id: id).last.destroy
        end
      end
    end
  end

  task create_new_channel: :environment do
    UserChannel.update_all(want_notification: true)
    channel1 = Channel.create(name: "Les services des Docks", channel_type: "group")
    channel2 = Channel.create(name: "Achats/Ventes des Docks", channel_type: "group")
    User.where.not(building_id: [1, 2]).each do |user|
      user.channels << channel1
      user.channels << channel2
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
