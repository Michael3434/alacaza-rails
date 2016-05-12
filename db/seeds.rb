# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Message.all.destroy_all
Building.all.destroy_all

building = Building.new(name: "12 Rue Jean Richepin", slug: "12-rue-jean-richepin", address: "12 rue Jean Richepin, 75116 Paris", password: "richepin789")
building.save
building = Building.new(name: "3 rue Elzevir", slug: "3-rue-elzevir", address: "3 rue Elzévir, 75003 Paris", password: "elzevir456")
building.save
building = Building.new(name: "10 rue des Bateliers", slug: "10-rue-des-bateliers", address: "10 rue des Bateliers, 93400 Saint-Ouen", password: "bateliers678")
building.save

user = User.new(first_name: "Alacaza", last_name: "Team", building_id: Building.where(name: "10 rue des Bateliers").last.id, password: "qwertyuiop", image_id: 1, admin: true, email: "hello@alacaza.fr", building_access: "bateliers678")
user.save!
user.update(image_id: 1)

body = "Bienvenue dans la communauté Alacaza !. Vous pouvez communiquer à l’ensemble des membres de l’immeuble dans ce fil de messages.
  Si vous avez la moindre question, n'hésitez pas à nous contacter au 07 68 45 33 00
L’équipe d’Alacaza – Alexis, Michael et Rémy"

message = Message.new(body: body, building_id: Building.where(name: "12 Rue Jean Richepin").last.id, user_id: User.where(first_name: "Alacaza").last.id)
message.save
message = Message.new(body: body, building_id: Building.where(name: "3 rue Elzevir").last.id, user_id: User.where(first_name: "Alacaza").last.id)
message.save
message = Message.new(body: body, building_id: Building.where(name: "10 rue des Bateliers").last.id, user_id: User.where(first_name: "Alacaza").last.id)
message.save


