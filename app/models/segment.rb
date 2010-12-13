class Segment
  include Carbon

  emit_as :shipment do
    provide :weight
    provide :package_count
    provide :carrier, :key => :name
    provide :origin, :as => :origin_zip_code
    provide :destination, :as => :destination_zip_code
    provide :mode_name, :as => :mode
    provide :segment_count
  end

  attr_accessor :origin, :depart, :destination, :arrive,
    :weight, :package_count, :mode

  def initialize(options = {})
    options.each do |name, value|
      self.send "#{name}=", value
    end
  end

  def carrier
    'FedEx'
  end

  def segment_count
    1
  end

  def origin_zip_code
    @origin_zip_code ||= ZipCode.find_by_name(origin)
  end

  def destination_zip_code
    @destination_zip_code ||= ZipCode.find_by_name(destination)
  end

  def length
    origin_zip_code.distance_to destination_zip_code
  end
  
  def departure
    Time.parse(depart.to_s)
  end
  
  def arrival
    Time.parse(arrive.to_s)
  end
  
  def duration # in seconds
    arrival - departure
  end
  
  def duration_in_minutes
    duration / 60
  end
  
  def duration_in_hours
    duration_in_minutes / 60
  end
  
  def speed
    length / duration_in_hours
  end
  
  def mode
    speed < 80 ? :ground : :air
  end

  def mode_name
    mode.to_s.humanize
  end

  def mode_with_indefinite_article
    case mode
    when :courier, :ground
      'a ground'
    when :air
      'an air'
    end
  end
  
  def origin_city
    origin_zip_code.description
  end
  
  def destination_city
    destination_zip_code.description
  end
  
  def range
    if origin_city == destination_city
      "Within #{origin_city}"
    else
      "#{origin_city}&ndash;#{destination_city}"
    end
  end

  def footprint
    emission_estimate.number
  end

  def methodology
    emission_estimate.methodology
  end
end
