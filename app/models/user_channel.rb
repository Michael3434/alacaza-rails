class UserChannel < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel


  def self.create_from_users(user1, user2)
  	
  end
end
