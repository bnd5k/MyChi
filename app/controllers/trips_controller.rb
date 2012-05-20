class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find_by_id(params[:id])
  end

  def new
  end

  def create
    @trip = Trip.new(params[:trip])
    if trip.save
      flash[:success] = "OK, time for some fun!"
      redirect_to trips_url
    else
      render 'new'
      flash[:error] = "Please try again"
    end
  end

  def edit
    @trip = Trip.find_by_id(params[:id])
  end

  def update
    @trip = Trip.find_by_id(params[:id])
    if @strip.update_attrutes(params[:trip])
      flash[:success] = "Cool.  Changes made."
      redirect_to trip_url
    else
      render 'edit'
      flash[:error] = "Please try again."
    end
  end

  def destroy
    Trip.find_by_id(params[:id]).destroy
    flash[:success] = "Trip has been deleted."
    redirect_to trips_url
  end
end
