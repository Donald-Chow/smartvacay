class LocationsController < ApplicationController
  def index
    @locations = policy_scope(Location)
  end

  def show
    @location = Location.find(params[:id])
    authorize @location

    @marker = [{ lat: @location.latitude, lng: @location.longitude }]
    p "marker: #{@marker}"
  end

  def favorite
    @location = Location.find(params[:id])
    authorize @location
    if current_user.favorited?(@location)
      current_user.unfavorite(@location)
      # flash[:notice] = "Location bookmark removed successfully."
    else
      current_user.favorite(@location)
      # flash[:notice] = "Location bookmarked successfully."
    end
  end

  def my_favorites
    @all_favorites = current_user.all_favorites
    # Favorite.for_favoritor(current_user) would also work
    authorize @all_favorites

    @category = params[:category]
    @locations = []

    @all_favorites.each do |favorite|
      location = favorite.favoritable
      if location.type_of_place.include?("restaurant") || location.type_of_place.include?("meal_takeaway") || location.type_of_place.include?("food")
        location.category = "food"
      elsif location.type_of_place.include?("department_store")
        location.category = "shopping"
      elsif location.type_of_place.include?("tourist_attraction")
        location.category = "sightseeing"
      else
        location.category = "miscellaneous"
      end
      @locations << location
    end

    if @category.present?
      return @locations_by_category = @locations.select { |location| location.category == @category }
    end
  end
end
