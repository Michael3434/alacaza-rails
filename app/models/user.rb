class User < ActiveRecord::Base
  has_secure_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
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
      if building.password == building_access.downcase
      else
        errors.add(:building_access)
      end
    end
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
    when "pierre@gmail.com"
      Building.where(slug: Building::PIERRE)
    else
      Building.all
    end
  end

  def private_channel_with(other_user)
    user_channels = self.private_channels.pluck(:channel_id)
    other_user_channels = other_user.private_channels.pluck(:channel_id)
    channel = (user_channels & other_user_channels)
    if channel.any?
      channel
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

end
