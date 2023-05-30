class LocationsController < ApplicationController
  before_action :set_location, only: %i[show favorite]

  def index
    @locations = policy_scope(Location)
    if params[:query].present?
      @results = GooglePlaces.new(query: params[:query], trip: current_user.trip).call.map do |location|
        Location.find_by(place_id: location["place_id"]) || Location.google_create(location_details(location["place_id"]))
      end
    end

    @top_attractions = @locations.select do |location|
      location.searches.find_by_trip_id(current_user.trip.id).category == "top_attractions"
    end

    @top_restaurants = @locations.select do |location|
      location.searches.find_by_trip_id(current_user.trip.id).category == "top_restaurants"
    end
  end

  def show
    authorize @location

    # User Review:
    @user_review = UserReview.new

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
    GooglePlaces.new(query: id).details
  end

  def set_location
    @location = Location.find(params[:id])
  end
end
