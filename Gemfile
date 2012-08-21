source 'http://rubygems.org'

gem 'rails', '3.2.8'

gem 'airbrake'
gem 'bson_ext'
gem 'cache'
gem 'cache_method'
gem 'carbon'
gem 'earth'
gem 'fozzie'
gem 'httpclient', '~>2.1' #for savon
gem 'lock_method'
gem 'mongo'
gem 'nori', '0.2.3'
gem 'savon', '0.9.2'
gem 'tronprint'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :production do
  gem 'dalli'
  gem 'pg'
end

group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'unicorn'
end

group :test do
  gem 'capybara'
  gem 'crack'
  gem 'cucumber-rails', :require => false
  gem 'rspec'
  gem 'rspec-rails'
  gem 'sqlite3-ruby', :require => 'sqlite3'
end
