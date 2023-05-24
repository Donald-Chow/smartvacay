class TripsController < ApplicationController
  before_action :set_trip, only: %i[show generate]

  def index
    @trips = policy_scope(Trip)
  end

  def show
    authorize @trip
    @grouped_itins = @trip.itineraries.group_by { |itin| itin[:start_time].to_date }
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    authorize @trip
    if @trip.save
      redirect_to locations_path
    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  def generate
    authorize @trip
    TripGenerator.new(current_user.favorited_location, @trip).call
    redirect_to trip_path(@trip)
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:destination, :start_date, :end_date)
  end
end
