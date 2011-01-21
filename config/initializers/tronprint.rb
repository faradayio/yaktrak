require 'tronprint'
require 'uri'

Tronprint.aggregator_options = {
  :adapter => :mongodb,
  :uri => URI.parse(ENV['MONGOHQ_URL']),
  :collection => 'tronprint'
}
