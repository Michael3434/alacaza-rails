class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
  validate :verify_building_password

  belongs_to :building
  has_many :messages
  # validations

  def verify_building_password
    building = Building.find(building_id)
    if building
      if building.password == building_access
      else
        errors.add(:building_access)
      end
    end
  end

  def name
    [first_name, last_name].join(' ')
  end


end
