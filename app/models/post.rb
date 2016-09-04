class Post < ActiveRecord::Base
  serialize :tags, Array
end
