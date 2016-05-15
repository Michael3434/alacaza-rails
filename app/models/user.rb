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
  # validations

  def verify_building_password
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
    self.update(image_id: (2..33).to_a.sample)
  end

end
