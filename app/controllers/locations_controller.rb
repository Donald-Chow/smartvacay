class LocationsController < ApplicationController

  def index
    @locations = policy_scope(Location)
  end

  def show
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
  end
end
