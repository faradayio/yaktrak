require 'tronprint'
require 'uri'

puts 'configuring tronprint'
uri = URI.parse ENV['MONGOHQ_URL']
Tronprint.aggregator_options = {
  :adapter => :mongodb,
  :host => uri.host,
  :port => uri.port,
  :db => uri.path.gsub('/','_'),
  :collection => 'tronprint'
}
