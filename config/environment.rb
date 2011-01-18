# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Yaktrak::Application.initialize!

if File.exist?(File.join(Rails.root, 'config', 'fedex.yml'))
  FEDEX = YAML::load(File.open(File.join(Rails.root, 'config', 'fedex.yml')))
else
  FEDEX = { # pull from env
    :key => ENV['FEDEX_KEY'],
    :password => ENV['FEDEX_PASSWORD'],
    :account => ENV['FEDEX_ACCOUNT'],
    :meter => ENV['FEDEX_METER']
  }
end
