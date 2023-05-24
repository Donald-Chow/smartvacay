class TripsController < ApplicationController
  before_action :set_trip, only: %i[show generate]

  def index
  end

  def show
    authorize @trip
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

  def generate
    authorize @trip
    @result = TripGenerator.new(current_user.favorited_location).make_itin
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:destination, :start_date, :end_date)
  end
end
