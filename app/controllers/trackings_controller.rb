class TrackingsController < ApplicationController
  def new
    @tracking = Tracking.new
  end
  
  def create
    @tracking = Tracking.find_or_create_by_package_identifier params[:tracking][:package_identifier]
    redirect_to @tracking
  end
  
  def show
    @new_tracking = Tracking.new
    @tracking = Tracking.find_by_package_identifier params[:id]
  end
end
