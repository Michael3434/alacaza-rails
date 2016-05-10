# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Message.all.destroy_all
Building.all.destroy_all

message = Message.new(body: "Bonjour à tous ! Je vous propose la création d'une boite de partage de livres entre voisins. Une minibibliothèque sera placée dans le hall pour que nous puissions échanger nos passionnants ouvrages ! Bien à vous", building_id: 5, user_id: 1)
message.save
message = Message.new(body: "Bonjour ! Je viens d'emménager dans l'immeuble, et en tant que nouveau résident je souhaite organiser une fête dans mon nouvel appartement. Passez quand vous voulez demain soir !   Martin PS: Quelqu'un pourrait-il m'aider à régler les formalités administratives d'arrivée dans l'immeuble ? ", building_id: 5, user_id: 1)
message.save
building = Building.new(name: "12 Rue Jean Richepin", slug: "12-rue-jean-richepin", address: "12 rue Jean Richepin, 75116 Paris", password: "richepin789")
building.save
building = Building.new(name: "3 rue Elzevir", slug: "3-rue-elzevir", address: "3 rue Elzévir, 75003 Paris", password: "elzevir456")
building.save
building = Building.new(name: "10 rue des Bateliers", slug: "10-rue-des-bateliers", address: "10 rue des Bateliers, 93400 Saint-Ouen", password: "bateliers678")
building.save
