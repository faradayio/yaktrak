class Tracking < ActiveRecord::Base
  set_primary_key :package_identifier
  attr_accessible :package_identifier
  
  def request
    { 'wsdl:WebAuthenticationDetail' => {
        'wsdl:UserCredential' => {
          'wsdl:Key' => 'YiFzxLrnuxsbq6w2',
          'wsdl:Password' => 'Sb5iDOVPDpcaPazLitzVpRhPh',
          :order! => ['wsdl:Key', 'wsdl:Password']
        }
      },
      'wsdl:ClientDetail' => {
        'wsdl:AccountNumber' => '510087747',
        'wsdl:MeterNumber' => '118522702'
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
  
  def track
    $soap_client.track do |soap|
      soap.input = 'TrackRequest'
      soap.body = request
    end.to_hash[:track_reply]
  end
end
