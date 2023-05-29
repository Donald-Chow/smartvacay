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

    @top_attractions =
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
    @all_favorites = current_user.all_favorites
    authorize @all_favorites
    @locations = []

    @all_favorites.each do |favorite|
      type_of_place = favorite.favoritable.type_of_place
      location = favorite.favoritable
      location.category = if type_of_place.include?("restaurant") || type_of_place.include?("meal_takeaway") || type_of_place.include?("food")
                            "food"
                          elsif type_of_place.include?("department_store") || type_of_place.include?("shopping_mall")
                            "shopping"
                          elsif type_of_place.include?("tourist_attraction")
                            "sightseeing"
                          else
                            "miscellaneous"
                          end
      @locations << location
    end

    @category = params[:category]

    @favorites = if @category.present?
                   @locations.select { |location| location.category == @category }
                 else
                   @all_favorites
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

# @all_favorites = current_user.all_favorites
# authorize @all_favorites

# @category = params[:category]
# @locations = []

# @all_favorites.each do |favorite|
#   location = favorite.favoritable
#   if location.type_of_place.include?("restaurant") || location.type_of_place.include?("meal_takeaway") || location.type_of_place.include?("food")
#     location.category = "food"
#   elsif location.type_of_place.include?("department_store")
#     location.category = "shopping"
#   elsif location.type_of_place.include?("tourist_attraction")
#     location.category = "sightseeing"
#   else
#     location.category = "miscellaneous"
#   end
#   @locations << location
# end

# if @category.present?
#   @locations_by_category = @locations.select { |location| location.category == @category }
# end
# end
