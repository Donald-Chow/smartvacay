require 'icalendar'

class TripsController < ApplicationController
  before_action :set_trip, only: %i[show generate generate_icalendar]

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
    params.require(:trip).permit(:destination, :start_date, :end_date)
  end
end
