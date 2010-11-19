class Segment < Struct.new(:origin, :depart, :destination, :arrive)
  def length
    ZipCode.find(origin).distance_to ZipCode.find(destination)
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
  
  def mode_with_indefinite_article
    case mode
    when :ground
      'a ground'
    when :air
      'an air'
    end
  end
  
  def origin_city
    ZipCode.find(origin).description
  end
  
  def destination_city
    ZipCode.find(destination).description
  end
  
  def range
    if origin_city == destination_city
      "Within #{origin_city}"
    else
      "#{origin_city}&ndash#{destination_city}"
    end
  end
end
