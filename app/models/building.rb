class Building < ActiveRecord::Base
  PIERRE = %w(
      2-rue-maurine-audin
      7-allee-de-paris
      5-allee-de-paris
      4-allee-de-paris
      5-rue-gisele-halimi
      6-allee-de-paris
      8-allee-de-paris
      10-rue-des-bateliers
    )
  ANABEL = %w(12-rue-jean-richepin)

  DOCKS_SLUG = ["2-rue-maurine-audin",
   "7-allee-de-paris",
   "5-allee-de-paris",
   "4-allee-de-paris",
   "5-rue-gisele-halimi",
   "6-allee-de-paris",
   "8-allee-de-paris",
   "10-rue-des-bateliers",
   "21-allee-de-paris",
   "23-allee-de-paris",
   "28-rue-la-cle-des-champs",
   "7-rue-maurice-audin",
   "15-allee-de-paris",
   "3-rue-maurice -audin",
   "13-allee-de-paris",
   "17-rue-de-la-cle-des-champs",
   "22-24-rue-de-la-cle-des-champs",
   "14-rue-de-la-cle-des-champs",
   "27-rue-de-la-cle-des-champs",
   "17-rue-des-bateliers",
   "10-rue-germaine-tillion",
   "12-rue-germaine-tillion",
   "14-rue-des-bateliers",
   "12-bis-rue-des-bateliers",
   "24-rue-des-bateliers",
   "30-rue-des-bateliers"]

  validates :slug, :name, :building_access, :address, presence: :true

  has_many :users
  has_many :messages
  has_many :channels

  after_create :create_processor

  def main_channel
    channels.where(channel_type: "main_group").last
  end

  def self.welcome
    "Bienvenue dans la communauté Alacaza ! Vous pouvez communiquer à l’ensemble des membres de l’immeuble dans ce fil de messages.
      Si vous avez la moindre question, n'hésitez pas à nous contacter au 07 68 45 33 00.
    L’équipe d’Alacaza – Alexis, Michael et Rémy"
  end

  def docks?
    self.slug.in?(DOCKS_SLUG)
  end

  def create_processor
    channel = Channel.create(building: self, name: "Tout l'immeuble", channel_type: "main_group")
    User.admin.channels << channel
    Message.create(body: Building.welcome, building_id: self.id, user_id: User.admin.id, channel_id: channel.id)
  end
end
