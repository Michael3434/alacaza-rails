class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :building
  belongs_to :channels
  has_many :comments, dependent: :destroy
end
