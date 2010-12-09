require 'spec_helper'

describe Segment do
  let(:depart) { Time.parse '2010-12-09 13:45:11' }
  let(:arrive) { Time.parse '2010-12-10 08:25:22' }
  let(:segment) do
    Segment.new :origin => '48915', :depart => depart.to_s,
      :destination => '22406', :arrive => arrive.to_s
  end

  describe '#length' do
    it 'should calculate the distance between zip codes in miles' do
      zip1 = mock ZipCode, :distance_to => 38
      zip2 = mock ZipCode
      ZipCode.stub!(:find).and_return(zip1, zip2)
      segment.length.should == 38
    end
  end
  
  describe '#departure' do
    it 'should parse the given time' do
      segment.departure.should == depart
    end
  end
  
  describe '#arrival' do
    it 'should parse the given time' do
      segment.arrival.should == arrive
    end
  end
  
  describe '#duration' do
    it 'should return the number of seconds between departure and arrival' do
      segment.duration.should == 67211.0
    end
  end
  
  describe '#duration_in_minutes' do
    it 'should return the number of minutes between departure and arrival' do
      segment.duration_in_minutes.should be_within(0.001).of(1120.183)
    end
  end
  
  describe '#duration_in_hours' do
    it 'should return the number of minutes between departure and arrival' do
      segment.duration_in_hours.should be_within(0.001).of(18.66972)
    end
  end
  
  describe '#speed' do
    it 'should return the speed of the segment in mph' do
      segment.stub!(:length).and_return 6
      segment.stub!(:duration_in_hours).and_return 2
      segment.speed.should == 3
    end
  end
  
  describe '#mode' do
    it 'should return :ground for speeds less than 80mph' do
      segment.stub!(:speed).and_return(67)
      segment.mode.should == :ground
    end
    it 'should return :air for speeds of 80mph or more' do
      segment.stub!(:speed).and_return(97)
      segment.mode.should == :air
    end
  end
  
  describe '#mode_with_indefinite_article' do
    it "should return 'a ground' for ground transportation" do
      segment.stub!(:mode).and_return(:ground)
      segment.mode_with_indefinite_article.should == 'a ground'
    end
    it "should return 'an air' for air transportation" do
      segment.stub!(:mode).and_return(:air)
      segment.mode_with_indefinite_article.should == 'an air'
    end
  end
  
  describe '#range' do
    it 'should return a range within the same locality' do
      segment.stub!(:origin_city).and_return('Lansing, MI')
      segment.stub!(:destination_city).and_return('Lansing, MI')
      segment.range.should == 'Within Lansing, MI'
    end
    it 'should return a range between different localities' do
      segment.stub!(:origin_city).and_return('Lansing, MI')
      segment.stub!(:destination_city).and_return('Reston, VA')
      segment.range.should == 'Lansing, MI&ndash;Reston, VA'
    end
  end

  describe '#footprint' do
    it 'should return the footprint for a given weight and package count' do
      segment.footprint 5, 2
    end
  end
end

