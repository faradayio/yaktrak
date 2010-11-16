class TrackingsController < ApplicationController
  def new
    @tracking = Tracking.new
  end
  
  def create
    @tracking = Track.create params[:tracking]
    redirect_to @tracking
  end
  
  def show
    @tracking = Tracking.find params[:tracking]
  end
end
