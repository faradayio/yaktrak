host = ENV['STATSD_HOST']
port = ENV['STATSD_PORT'] || '8125'
Stats = Statsd.new(host, port)
Stats.namespace = 'yaktrak'
