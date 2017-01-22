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

  task update_channel_name: :environment do
    Channel.where(name: "Les services des Docks").last.update(name: "Quartier des Docks")
  end

  task update_services_categories: :environment do

    Service.find_by_id(44).try(:destroy)
    Service.find_by_id(57).try(:destroy)
    Service.find_by_id(58).try(:destroy)
    Service.find_by_id(45).try(:destroy)
    Service.find_by_id(20).try(:destroy)
    Service.find_by_id(59).try(:destroy)
    Service.find_by_id(52).try(:destroy)
    Service.find_by_id(50).try(:destroy)
    Service.find_by_id(49).try(:destroy)
    Service.find_by_id(47).try(:destroy)
    Service.find_by_id(42).try(:destroy)
    Service.find_by_id(41).try(:destroy)
    Service.find_by_id(36).try(:destroy)
    Service.find_by_id(40).try(:destroy)
    Service.find_by_id(31).try(:destroy)
    Service.find_by_id(29).try(:destroy)
    Service.find_by_id(27).try(:destroy)
    Service.find_by_id(25).try(:destroy)
    Service.find_by_id(22).try(:destroy)
    Service.find_by_id(23).try(:destroy)
    Service.find_by_id(17).try(:destroy)
    Service.find_by_id(33).try(:destroy)
    Service.find_by_id(15).try(:destroy)
    Service.find_by_id(5).try(:destroy)
    Service.find_by_id(6).try(:destroy)
    Service.find_by_id(3).try(:destroy)
    Service.find_by_id(54).try(:destroy)
    Service.find_by_id(51).try(:destroy)
    Service.find_by_id(39).try(:destroy)

    Service.all.update_all(category: nil)

    Service.find(4).update(category: "Cours particuliers et coaching")
    Service.find(8).update(category: "Immobiler (achat, location et co-location)")
    Service.find(16).update(category: "Nettoyage, repassage et cuisine")
    Service.find(12).update(category: "Babysitting et nounous")
    Service.find(10).update(category: "Babysitting et nounous")
    Service.find(11).update(category: "Babysitting et nounous")
    Service.find(9).update(category: "Cours particuliers et coaching")
    Service.find(35).update(category: "Cours particuliers et coaching", description: "Cours de soutien")
    Service.find(14).update(category: "Babysitting et nounous")
    Service.find(1).update(category: "Prestations web, design, photo")
    Service.find(18).update(category: "Sports, loisirs et événements")
    Service.find(19).update(category: "Babysitting et nounous")
    Service.find(13).update(category: "Nettoyage, repassage et cuisine")
    Service.find(28).update(category: "Transport, co-voiturage")
    Service.find(21).update(category: "Réparations et dépannage")
    Service.find(37).update(category: "Babysitting et nounous")
    Service.find(30).update(category: "Réparations et dépannage")
    Service.find(38).update(category: "Mode, beauté et bien-être")
    Service.find(34).update(category: "Babysitting et nounous")
    Service.find(24).update(category: "Cours particuliers et coaching")
    Service.find(46).update(category: "Nettoyage, repassage et cuisine")
    Service.find(48).update(category: "Nettoyage, repassage et cuisine")
    Service.find(55).update(category: "Babysitting et nounous")
    Service.find(53).update(category: "Babysitting et nounous")
    Service.find(7).update(category: "Babysitting et nounous", description: "Je suis actuellement éducatrice")
    Service.find(2).update(category: "Babysitting et nounous")
    Service.find(60).update(category: "Babysitting et nounous")
    Service.find(43).update(category: "Babysitting et nounous", description: "Babysitting")
    Service.find(32).update(category: "Babysitting et nounous")
    Service.find(26).update(category: "Babysitting et nounous", description: "Garde d'enfants")
    Service.find(56).update(category: "Mode, beauté et bien-être", description: "Maquilleuse")

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
