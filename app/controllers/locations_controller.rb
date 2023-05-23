class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def show
  end

  def favorite
    @location = Location.find(params[:id])
    if current_user.favorited?(@location)
      current_user.unfavorite(@location)
    else
      current_user.favorite(@location)
    end
    # head :ok
  end
end
