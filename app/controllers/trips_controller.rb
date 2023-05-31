require 'icalendar'

class TripsController < ApplicationController
  before_action :set_trip, only: %i[show generate update generate_icalendar]

  def index
    @trips = policy_scope(Trip)
  end

  def show
    authorize @trip
    @grouped_itins = @trip.itineraries
    # @grouped_itins = @trip.itineraries.group_by { |itin| itin[:start_time].to_date }
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    geocode = GooglePlaces.new(trip: @trip).geocode
    @trip.lat = geocode["lat"]
    @trip.lng = geocode['lng']
    authorize @trip
    if @trip.save
      # create Top Attractions
      create_top_attractions(@trip)
      # create Top Restaurants
      create_top_restaurants(@trip)
      # create Top Shopping
      create_top_shopping(@trip)
      redirect_to locations_path

    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  def update
    authorize @trip
    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      render "show", status: :unprocessable_entity
      flash[:alert] = "Update failed. Contact Doug"
    end
  end

  def generate
    authorize @trip
    TripGenerator.new(current_user.favorited_location, @trip).call
    redirect_to trip_path(@trip)
  end

  def generate_icalendar
    authorize @trip

    cal = Icalendar::Calendar.new

    @trip.itineraries.each do |itinerary|
      event = Icalendar::Event.new
      event.dtstart = itinerary.start_time
      event.summary = itinerary.location.name
      event.location = itinerary.location.address
      # event.dtend = itinerary.end_time
      event.description = itinerary.location.description

      cal.add_event(event)
    end

    cal.publish

    ical_data = cal.to_ical

    filename = 'itinerary.ics'

    # Set the response headers for automatic download and import into Google Calendar
    headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
    headers['Content-Type'] = 'text/calendar'
    headers['X-WR-CALNAME'] = 'Trip' # Set your desired calendar name here

    # Send the iCalendar data as the response
    render plain: ical_data
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:destination, :start_date, :end_date, :driving)
  end

  def create_top_attractions(trip)
    query = "Top #{trip.destination} Attractions"
    GooglePlaces.new(query:, trip: @trip).call.map do |place|
      # if location exists, create search "bookmark"
      location = Location.find_by(place_id: place["place_id"]) ||
                 # if location does not exists, create the location, and create search "bookmark"
                 Location.google_create(GooglePlaces.new(query: place["place_id"]).details)
      save_search(trip, location, "top_attractions", query)
    end
  end

  def create_top_restaurants(trip)
    query = "Top #{trip.destination} Restaurants"
    GooglePlaces.new(query:, trip: @trip).call.map do |place|
      # if location exists, create search "bookmark"
      location = Location.find_by(place_id: place["place_id"]) ||
                 # if location does not exists, create the location, and create search "bookmark"
                 Location.google_create(GooglePlaces.new(query: place["place_id"]).details)
      save_search(trip, location, "top_restaurants", query)
    end
  end

  def create_top_shopping(trip)
    query = "Top #{trip.destination} Shopping"
    GooglePlaces.new(query:, trip: @trip).call.map do |place|
      # if location exists, create search "bookmark"
      location = Location.find_by(place_id: place["place_id"]) ||
                 # if location does not exists, create the location, and create search "bookmark"
                 Location.google_create(GooglePlaces.new(query: place["place_id"]).details)
      save_search(trip, location, "top_shoppings", query)
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
