class Tracking < ActiveRecord::Base
  set_primary_key :package_identifier
  attr_accessible :package_identifier
  
  def request
    { 'wsdl:WebAuthenticationDetail' => {
        'wsdl:UserCredential' => {
          'wsdl:Key' => FEDEX[:key],
          'wsdl:Password' => FEDEX[:password],
          :order! => ['wsdl:Key', 'wsdl:Password']
        }
      },
      'wsdl:ClientDetail' => {
        'wsdl:AccountNumber' => FEDEX[:account],
        'wsdl:MeterNumber' => FEDEX[:meter]
      },
      'wsdl:Version' => {
        'wsdl:ServiceId' => 'trck',
        'wsdl:Major' => '4',
        'wsdl:Intermediate' => '1',
        'wsdl:Minor' => '0'
      },
      'wsdl:PackageIdentifier' => {
        'wsdl:Value' => package_identifier.to_s,
        'wsdl:Type' => 'TRACKING_NUMBER_OR_DOORTAG',
        :order! => ['wsdl:Value', 'wsdl:Type']
      },
      'wsdl:IncludeDetailedScans' => 'true',
      :order! => [ 'wsdl:WebAuthenticationDetail', 'wsdl:ClientDetail', 'wsdl:Version', 'wsdl:PackageIdentifier', 'wsdl:IncludeDetailedScans']
    }
  end
  
  def tracking_details
    @tracking_details ||= $soap_client.track do |soap|
      soap.input = 'TrackRequest'
      soap.body = request
    end.to_hash[:track_reply]
  end
  
  def events
    tracking_details[:track_details][:events].map{ |event| Event.new event[:address][:postal_code], event[:timestamp], event[:event_type] }.reverse
  end
  
  def nodes
    events.map(&:zipcode).compact.uniq
  end
  
  def segments
    events.select(&:zipcode).inject([]) do |memo, event|
      if memo.empty?
        memo << Segment.new(event.zipcode, event.timestamp)
      elsif memo.last.origin == event.zipcode and not memo.last.destination
        memo.last.depart = event.timestamp
      elsif memo.last.destination and memo.last.destination == event.zipcode
        memo << Segment.new(event.zipcode, event.timestamp)
      elsif memo.last.destination
        memo << Segment.new(memo.last.destination, memo.last.arrival, event.zipcode, event.timestamp)
      else
        memo.last.destination = event.zipcode
        memo.last.arrive = event.timestamp
      end
      memo
    end
  end
  
  def delivered?
    events.find { |e| e.type == 'DL' }
  end
  
  def status
    delivered? ? :delivered : :en_route
  end
end
