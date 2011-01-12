$soap_client = Savon::Client.new do
  wsdl.document = 'http://cloud.github.com/downloads/brighterplanet/yaktrak/fedex_track-production.wsdl'
  #wsdl.endpoint = "https://ws.fedex.com:443/web-services/track"
  #wsdl.namespace = "http://fedex.com/ws/track/v4"
end
