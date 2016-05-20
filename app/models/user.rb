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

  belongs_to :building
  has_many :messages
  has_many :comments
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
    [first_name, last_name].join(' ')
  end

  def set_image_id
    user = User.all.last(2).first
    image_id = user.image_id + 1
    image_id = image_id > 33 ? 2 : image_id
    self.update(image_id: image_id)
  end

end
