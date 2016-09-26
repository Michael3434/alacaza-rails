source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '4.2.4'
gem 'rack-cors'

# gem 'faye-rails', '~> 2.0'
# gem 'thin'

## BACK END ##
gem 'pg'
gem 'slack-notifier'

# Select2 - multiple select boxes
gem 'select2-rails'

gem 'has_secure_token'

# Graph
gem 'groupdate'
gem "chartkick"

#Auto link for messages

gem 'rails_autolink'

gem 'carrierwave'
gem 'cloudinary'

## Backround job
gem "sidekiq"
gem 'redis'

# Needed to build the Sidekiq web interface
gem 'sinatra', :require => nil

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Jquery & Jquery plugins
# Provides latest versions of jquery and jquery-ujs adapter
gem 'jquery-rails'
# Jquery UI (css and js with ui effects)
gem 'jquery-ui-rails'
# Provides a handler for getting and setting cookies
gem 'jquery-cookie-rails'

## FRONT END ##
gem 'bootstrap-sass', '~> 3.3.3'
gem 'bootstrap-datepicker-rails'
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'simple_form'

# Icons
gem 'font-awesome-sass', '~> 4.4.0'

# Paperclip and delayed uploads to S3
gem 'paperclip'
gem 'delayed_paperclip'
gem 'aws-sdk', '< 2.0'

gem 'devise', '~> 3.5.2'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  gem "better_errors"
  gem "quiet_assets"
  gem "binding_of_caller"
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-sidekiq', git: 'git@github.com:johnvoloski/spring-commands-sidekiq.git', branch: 'master'
end

group :production, :staging do
  gem 'rails_12factor'
end

# Config file
gem "figaro"

# Server
gem 'puma'
# gem "rack-timeout"
