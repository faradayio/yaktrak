require 'spec_helper'
require 'crack'

describe Tracking do
  let(:bad_response) do
    s = {
      :track_reply => {
        :highest_severity => 'ERROR',
        :notifications => {
          :severity => 'ERROR',
          :source => 'trck',
          :code => '9040',
          :message => 'No information for the following shipments has been received by our system yet.  Please try again or contact Customer Service at 1.800.Go.FedEx(R) 800.463.3339.',
          :localized_message => 'No information for the following shipments has been received by our system yet.  Please try again or contact Customer Service at 1.800.Go.FedEx(R) 800.463.3339.'
        }
      }
    }
  end
  let(:good_response) {
    soap = File.read File.expand_path('../fixtures/382544330058603.xml', File.dirname(__FILE__))
    Crack::XML.parse(soap).find_soap_body
  }
  let(:tracking) { Tracking.new :package_identifier => '56901001514000381668' }

  it 'should calculate emissions based on a tracking number'
  it 'should retrieve events for a valid delivery'
  it 'should create segments for tracking number 045720415008981' do
    soap = File.read File.expand_path('../fixtures/045720415008981.xml', File.dirname(__FILE__))
    crack = Crack::XML.parse(soap).find_soap_body
    $soap_client.stub!(:request).and_return mock(Object, :to_hash => crack)
    tracking.segments.should_not be_empty
  end
  it 'should create segments for tracking number 797093105287' do
    soap = File.read File.expand_path('../fixtures/797093105287.xml', File.dirname(__FILE__))
    crack = Crack::XML.parse(soap).find_soap_body
    $soap_client.stub!(:request).and_return mock(Object, :to_hash => crack)
    puts tracking.segments.inspect
    tracking.segments.length.should == 4
    tracking.segments.each do |segment|
      segment.mode_with_indefinite_article.should_not be_nil
      segment.departure.should be_a_kind_of(Time)
    end
  end

  describe '#tracking_response' do
    it 'should return the hash of tracking details' do
      $soap_client.stub!(:track).and_return mock(Object, :to_hash => good_response)
      tracking.tracking_response.should be_a_kind_of(Hash)
    end
    it 'should raise an error if an invalid number is entered' do
      $soap_client.stub!(:track).and_return bad_response
      expect do
        tracking.tracking_response
      end.to raise_error(Tracking::Failure)
    end
  end

  describe '#weight' do
    it 'should return the package weight in lbs' do
      $soap_client.stub!(:track).and_return mock(Object, :to_hash => good_response)
      tracking.weight.should == '19.0'
    end
    it 'should return nil if no weight is given' do
      no_weight_response = good_response
      no_weight_response[:track_reply][:track_details].delete :package_weight
      $soap_client.stub!(:track).and_return no_weight_response
      tracking.weight.should be_nil
    end
  end

  describe '#package_count' do
    it 'should return the package package count' do
      $soap_client.stub!(:track).and_return mock(Object, :to_hash => good_response)
      tracking.package_count.should == '1'
    end
    it 'should return nil if no package count is given' do
      no_package_count_response = good_response
      no_package_count_response[:track_reply][:track_details].delete :package_count
      $soap_client.stub!(:track).and_return no_package_count_response
      tracking.package_count.should be_nil
    end
  end

  describe '#delivered?' do
    it 'should return true if there is a delivery event' do
      delivery_event = mock Event, :delivery? => true
      tracking.stub!(:events).and_return [delivery_event]
      tracking.should be_delivered
    end
    it 'should return false if there is no delivery event' do
      event = mock Event, :delivery? => false
      tracking.stub!(:events).and_return [event]
      tracking.should_not be_delivered
    end
  end

  describe '#status' do
    it 'should return :delivered if package is delivered' do
      tracking.stub!(:delivered?).and_return true
      tracking.status.should == :delivered
    end
    it 'should return :en_route if package is not delivered' do
      tracking.stub!(:delivered?).and_return false
      tracking.status.should == :en_route
    end
  end

  describe '#footprint' do
    it 'should return the sum of footprints for each segment' do
      seg1 = mock Segment, :footprint => 34
      seg2 = mock Segment, :footprint => 44
      seg3 = mock Segment, :footprint => 54
      tracking.stub!(:segments).and_return [seg1, seg2, seg3]
      tracking.footprint.should == 132
    end
    it 'should return 0 if there are no segments' do
      tracking.stub!(:segments).and_return []
      tracking.footprint.should == 0
    end
  end

  describe '#segments' do
    it 'should return an empty array if there are no events' do

    end
  end
end

