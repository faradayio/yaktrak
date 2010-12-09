require 'spec_helper'

describe Event do
  let(:event) { Event.new }
  describe '#delivery?' do
    it 'should return true if type is DL' do
      event.type = 'DL'
      event.should be_delivery
    end
    it 'should return false if type is not DL' do
      event.type = 'PK'
      event.should_not be_delivery
    end
  end
end

