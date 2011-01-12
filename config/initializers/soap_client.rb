$soap_client = Savon::Client.new do
  #wsdl.document = 'http://banjo.brighterplanet.com/andy/TrackService_v4.wsdl'
  wsdl.endpoint = "https://ws.fedex.com:443/web-services/track"
  wsdl.namespace = "http://fedex.com/ws/track/v4"
end
