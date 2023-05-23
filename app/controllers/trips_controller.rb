class TripsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    authorize @trip
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:destination, :start_date, :end_date)
  end
end
