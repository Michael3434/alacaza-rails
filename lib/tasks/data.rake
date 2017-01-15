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

  task send_happy: :environment do
    User.joins(:building).where('buildings.district = ?', 'Docks').uniq.each do |user|
      UserMailer.happy(user).deliver!
    end
  end

  task remove_users_from_channel: :environment do
    c = Channel.where(name: "Achats/Ventes des Docks").last
    UserChannel.where(channel: c).where.not(user: User.where(email: "hello@alacaza.fr")).destroy_all
  end

  task add_new_users: :environment do
    CSV.foreach('db/users_1.csv', headers: true) do |row|
      password = "#{row["first_name"]}-#{rand(99999)}"
      user = User.find_by_email(row["email"])
      user.password = password
      user.password_confirmation = password
      user.save!
      Mailer::UserMailerWorker.perform_async(:welcome_with_password, user_id: user.id, password: password)
    end
  end

  task export_messages: :environment do
    CSV.open("db/messages_export.csv", "a") do |csv|
      Message.where('created_at > ?', Date.parse("16/10/08")).each do |message|
        csv << [message.id, message.user.id, message.user.name, message.user.building.name, message.body, message.created_at, message.channel.name, message.channel.channel_type]
      end
    end
  end

  task export_users: :environment do
    CSV.open("db/users_export.csv", "a") do |csv|
      User.where('created_at > ?', Date.parse("16/10/09")).all.each do |user|
        p user.id
        csv << [user.created_at, user.id, user.name, user.building.name]
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
