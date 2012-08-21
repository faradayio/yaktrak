class TrackingsController < ApplicationController
  def new
    @tracking = Tracking.new
  end
  
  def create
    Stats.time 'tracking_time' do
      @tracking = Tracking.find_or_create_by_package_identifier params[:tracking][:package_identifier]
    end
    Stats.increment 'trackings'
    Stats.increment 'trackings.example' if @tracking.example?
    redirect_to @tracking
  end
  
  def show
    @new_tracking = Tracking.new
    @tracking = Tracking.find_or_create_by_package_identifier params[:id]
    begin
      @tracking.footprint
    rescue Tracking::Failure
      Stats.increment 'trackings.failure'
      render :failure
    rescue Tracking::International
      Stats.increment 'trackings.international'
      render :international
    rescue Tracking::NoSegmentInformation
      Stats.increment 'trackings.too_old'
      render :too_old
    end
  end
end
