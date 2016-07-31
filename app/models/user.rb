class User < ActiveRecord::Base
  has_secure_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :floor, :door, presence: true
  validates :token, uniqueness: true, allow_blank: true
  validate :verify_building_password

  after_create :set_image_id
  after_create :set_channel

  belongs_to :building
  has_many :messages
  has_many :comments
  has_many :user_channels, dependent: :destroy
  has_many :channels, through: :user_channels, dependent: :destroy

  # validations

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
    [first_name.capitalize, last_name.capitalize].join(' ')
  end

  def set_image_id
    user = User.all.last(2).first
    image_id = user.image_id + 1
    image_id = image_id > 33 ? 2 : image_id
    self.update(image_id: image_id)
  end

  def set_channel
    channel = Channel.where(building_id: building_id, channel_type: "main_group").last
    UserChannel.create(user: self, channel: channel)
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

end
