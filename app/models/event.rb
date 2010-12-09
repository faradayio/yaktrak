class Event < Struct.new(:zipcode, :timestamp, :type)
  def delivery?
    type == 'DL'
  end
end
