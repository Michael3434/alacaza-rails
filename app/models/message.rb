class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :building
  has_many :comments, dependent: :destroy
end
