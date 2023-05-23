class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
    authorize @location

    @marker = [{lat: @location.latitude, lng: @location.longitude}]
    p "marker: #{@marker}"

  end

end
