class TrackingsController < ApplicationController
  def new
    @tracking = Tracking.new
  end
  
  def create
    @tracking = Tracking.create params[:tracking]
    redirect_to @tracking
  end
  
  def show
    @new_tracking = Tracking.new
    @tracking = Tracking.find_by_package_identifier params[:id]
  end
end
