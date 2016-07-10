class Lead < ActiveRecord::Base
  validates :first_name, :last_name, :code , :address, :floor, :command, :phone, presence: true
end
