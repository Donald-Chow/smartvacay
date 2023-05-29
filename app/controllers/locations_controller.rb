require "uri"

class LocationsController < ApplicationController
  before_action :set_location, only: %i[show favorite]

  def index
    @locations = policy_scope(Location)

    if params[:query].present?
      @results = GooglePlaces.new(params[:query]).call.map do |location|
        Location.find_by(place_id: location["place_id"]) || location_from_google(location)
      end
    else
      @results = []
    end

    @top_attractions = location.all
    # GooglePlaces.new("Top #{current_user.trip.destination} Attractions").call.map do |location|
    #   Location.find_by(place_id: location["place_id"]) || Location.google_create(location_details(location["place_id"]))
    # end

    @top_restaurants = location.all
    # GooglePlaces.new("Top #{current_user.trip.destination} Restaurants").call.map do |location|
    #   Location.find_by(place_id: location["place_id"]) || Location.google_create(location_details(location["place_id"]))
    # end
  end

  def show
    authorize @location

    @marker = [{ lat: @location.latitude, lng: @location.longitude }]
    "marker: #{@marker}"
  end

  def favorite
    authorize @location
    if current_user.favorited?(@location)
      current_user.unfavorite(@location)
    else
      current_user.favorite(@location)
    end
  end

  def my_favorites
    @all_favorites = current_user.favorited_location
    authorize @all_favorites

    @category = params[:category]

    @favorites = if @category.present?
                   raise
                   @all_favorites.select { |location| location.category == @category }
                 else
                   @all_favorites
                 end

    respond_to do |format|
      format.html
      # Render the filtered list as a separate JavaScript view template
      format.text { render partial: "filtered_list", locals: { favorites: @favorites }, formats: [:html] }
    end
  end

  private

  def location_details(id)
    GooglePlaces.new(id).details
  end

  def set_location
    @location = Location.find(params[:id])
  end
end
