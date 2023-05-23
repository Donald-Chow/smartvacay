class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def show
  end
end
