class ItinerariesController < ApplicationController
  def index
  end

  def create
    Itinerary.new
  end

  def update
    # Do what you want with todo_params.
  end

  private

  def todo_params
    params.require(:todo).permit(:position)
  end
end
