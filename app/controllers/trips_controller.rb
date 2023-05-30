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
      # create Top Attractions
      create_top_attractions(@trip)
      # create Top Restaurants
      create_top_restaurants(@trip)
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

  def create_top_attractions(trip)
    query = "Top #{trip.destination} Attractions"
    GooglePlaces.new(query).call.map do |place|
      # if location exists, create search "bookmark"
      location = Location.find_by(place_id: place["place_id"]) ||
                 # if location does not exists, create the location, and create search "bookmark"
                 Location.google_create(GooglePlaces.new(place["place_id"]).details)
      save_search(trip, location, "top_attractions", query)
    end
  end

  def create_top_restaurants(trip)
    query = "Top #{trip.destination} Restaurants"
    GooglePlaces.new(query).call.map do |place|
      # if location exists, create search "bookmark"
      location = Location.find_by(place_id: place["place_id"]) ||
                 # if location does not exists, create the location, and create search "bookmark"
                 Location.google_create(GooglePlaces.new(place["place_id"]).details)
      save_search(trip, location, "top_restaurants", query)
    end
  end

  def save_search(trip, location, category, query)
    search = Search.new(
      query:,
      category:
    )
    search.trip = trip
    search.location = location
    search.save
  end
end
