source 'https://rubygems.org'

ruby '2.6.6'

gem 'omniauth'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
gem "omniauth-rails_csrf_protection"
gem 'dotenv-rails', groups: [:development, :test]

gem 'lazy_high_charts'
gem 'groupdate'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use Haml as the templating library
gem 'haml'
gem 'bcrypt'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.10'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 2.7.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Timezone data for windows users
gem "tzinfo-data"
gem 'mailgun-ruby'
# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
   # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console' 
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec', '~>3.5'
  gem 'rspec-rails'
  gem 'guard-rspec'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.3.0'

end

group :test do
  gem 'simplecov', require: false
  gem 'rspec-expectations'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner'
end

group :production do
  gem 'pg', '~> 0.20' # for Heroku deployment
  gem 'rails_12factor'
end
