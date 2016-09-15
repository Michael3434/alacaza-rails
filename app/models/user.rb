class User < ActiveRecord::Base
  has_secure_token
  mount_uploader :photo, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
  validates_presence_of :floor, :door, :on => :create
  validates :token, uniqueness: true, allow_blank: true
  validate :verify_building_password, :on => :create

  after_create :set_image_id
  after_create :set_channel
  after_create :set_group_channel

  after_update :change_building_processor, if: :building_id_changed?

  belongs_to :building
  has_many :messages, dependent: :destroy
  has_many :comments
  has_many :user_channels, dependent: :destroy
  has_many :channels, through: :user_channels, dependent: :destroy
  has_many :posts, dependent: :destroy

  # validations

  def self.to_be_notify(message)
    where.not(id: message.user.id)
    .joins(:user_channels)
    .where(user_channels: {channel_id: message.channel_id, want_notification: true })
  end

  def user_channels_group
    user_channels
    .joins(:channel)
    .where('channels.channel_type in (?)', ["group", "main_group"])
    .order("channels.channel_type = 'main_group' asc")
  end

  def verify_building_password
    return false unless building_id
    building = Building.find(building_id)
    if building
      if building.building_access == building_access.downcase
      else
        errors.add(:building_access)
      end
    end
  end

  def self.search(options = {})
    options.inject(User) do |scope, (field, value)|
      case field.to_sym
      when :events
        joins(:events).having("count(events.id) >= #{value}").group("users.id")
      else
        scope
      end
    end
  end

  def self.admin
    find_by_email("hello@alacaza.fr")
  end

  def name
    pseudo || [first_name, last_name.capitalize].join(' ')
  end

  def buildings_associate
    case self.email
    when ENV["PIERRE"]
      Building.where(slug: Building::PIERRE)
    when ENV["ANABEL"]
      Building.where(slug: Building::ANABEL)
    else
      Building.all
    end
  end

  def private_channel_with(other_user)
    user_channels = self.private_channels.pluck(:channel_id)
    other_user_channels = other_user.private_channels.pluck(:channel_id)
    channel = (user_channels & other_user_channels)
    if channel.any?
      Channel.find(channel.first)
    else
      false
    end
  end

  def private_channels
    channels.where(channel_type: "private")
  end

  def group_channels
    channels.where(channel_type: "group")
  end

  def all_group_channels
    channels.where(channel_type: ["group", "main_group"])
  end

  def pierre?
    email == ENV["PIERRE"]
  end

  def anabel?
    email == ENV["ANABEL"]
  end

  def build_colis_message
    if building.slug.in? Building::PIERRE
      "Bonjour #{first_name}
      Je vous informe que votre colis a bien été réceptionné dans votre immeuble du #{building.address}.
      Vous pouvez le récupérer dans ma loge située dans l’immeuble Soho / Noho (code d’entrée : 7680), généralement ouverte le matin (de 9h00 à 12h00).
      Si vous n’êtes pas disponible à ce moment-là, vous pouvez me joindre au +33 6 31 20 24 19 que nous puissions convenir d’un moment pour vous transmettre votre colis.
      Pierre, votre gardien-régisseur d'immeuble"
    elsif building.slug.in? Building::ANABEL
      "Bonjour #{first_name}
      Je vous informe que votre colis a bien été réceptionné dans votre immeuble du #{building.address}.
      Vous pouvez le récupérer dans ma loge.
      Anabel votre gardienne d'immeuble"
    end
  end

  def self.search(options = {})
    options.inject(User) do |scope, (field, value)|
      next scope if value.blank?
      case field.to_sym
      when :building
        scope.where(building_id: value)
      else
        scope
      end
    end
  end

  #
  # Callbacks
  #

  def set_image_id
    user = User.all.last(2).first
    image_id = user.image_id + 1
    image_id = image_id > 33 ? 2 : image_id
    self.update(image_id: image_id)
  end

  def set_channel
    channel = Channel.where(building_id: building_id, channel_type: "main_group").last
    self.channels << channel
  end

  def set_group_channel
    if self.building.docks?
      c1 = Channel.where(name: "Les services des Docks").last
      c2 = Channel.where(name: "Achats/Ventes des Docks").last
      UserChannel.create(user: self, channel: c1, want_notification: false)
      UserChannel.create(user: self, channel: c2, want_notification: false)
    end
  end

  def change_building_processor
    return if building_id_was.nil?
    self.building_access = self.building.building_access
    self.user_channels.each do |user_channel|
      if user_channel.channel.channel_type == "main_group"
        user_channel.destroy
      end
    end
    channel = Channel.where(channel_type: "main_group", building_id: self.building.id).last
    self.messages.joins(:channel).where('channels.channel_type = ?', 'main_group').update_all(channel_id: channel.id)
    self.channels << channel
  end

end
