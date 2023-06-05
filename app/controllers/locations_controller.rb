class LocationsController < ApplicationController
  before_action :set_location, only: %i[show favorite]

  def index
    @locations = policy_scope(Location)

    if params[:query].present?
      @results = GooglePlaces.new(query: params[:query], trip: current_user.trip).call.map do |location|
        Location.find_by(place_id: location["place_id"]) || Location.google_create(location_details(location["place_id"]))
        # save to searches search
      end
      @results.each do |location|
        save_search(current_user.trip, location, "user_searches", params[:query])
      end
    end

    if current_user.favorited_location.count != 0
      tags = []
      accept = %w[accounting
                  airport
                  atm
                  bakery
                  bank
                  bar
                  beauty_salon
                  bicycle_store
                  book_store
                  bowling_alley
                  cafe
                  campground
                  car_dealer
                  car_rental
                  casino
                  cemetery
                  church
                  city_hall
                  clothing_store
                  convenience_store
                  courthouse
                  department_store
                  doctor
                  drugstore
                  electronics_store
                  embassy
                  fire_station
                  florist
                  funeral_home
                  furniture_store
                  gas_station
                  gym
                  hair_care
                  hardware_store
                  hindu_temple
                  home_goods_store
                  hospital
                  jewelry_store
                  library
                  light_rail_station
                  liquor_store
                  local_government_office
                  meal_delivery
                  meal_takeaway
                  mosque
                  movie_theater
                  museum
                  night_club
                  park
                  pharmacy
                  restaurant
                  rv_park
                  shoe_store
                  shopping_mall
                  spa
                  stadium
                  store
                  subway_station
                  synagogue
                  train_station
                  university
                  zoo]
      # takes favorited tags
      current_user.favorited_location.each do |location|
        location.type_of_place.split(", ").each do |type|
          tags << type if accept.include?(type)
        end
      end
      # take search tags
      current_user.trip.searches.where(category: 'user_searches').each do |search|
        search.location.type_of_place.split(", ").each do |type|
          tags << type if type != "point_of_interest" && type != "establishment" && type != "tourist_attraction"
        end
      end
      # clean key words (if i take queries)
      # random key words search
      if tags != []
        @query = tags.uniq.sample.gsub('_', ' ').to_s
        @recommendations = GooglePlaces.new(query: @query, trip: current_user.trip).call.map do |location|
          Location.find_by(place_id: location["place_id"]) || Location.google_create(location_details(location["place_id"]))
          # save to searches recommended history
        end
      end
    end

    @top_attractions = @locations.select do |location|
      location.searches.find_by_trip_id(current_user.trip.id).category == "top_attractions"
    end

    @top_restaurants = @locations.select do |location|
      location.searches.find_by_trip_id(current_user.trip.id).category == "top_restaurants"
    end

    @top_shoppings = @locations.select do |location|
      location.searches.find_by_trip_id(current_user.trip.id).category == "top_shoppings"
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
