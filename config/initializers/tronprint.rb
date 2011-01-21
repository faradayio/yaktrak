require 'tronprint'
require 'uri'

Tronprint.aggregator_options = {
  :adapter => :mongodb,
  :uri => ENV['MONGOHQ_URL'],
  :collection => 'tronprint'
}
