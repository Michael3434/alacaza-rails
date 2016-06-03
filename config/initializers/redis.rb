p "In redis.rb"
uri = URI.parse(ENV["REDISTOGO_URL"])
p uri
REDIS = Redis.new(:url => uri)
p REDIS