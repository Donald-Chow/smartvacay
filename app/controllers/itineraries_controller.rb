class ItinerariesController < ApplicationController
  def index
  end

  def create
    Itinerary.new
  end

  def update
    # Do what you want with todo_params.
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    authorize @itinerary
    @itinerary.destroy
    redirect_to trip_path(@itinerary.trip), status: :see_other
  end

  private

  def todo_params
    params.require(:todo).permit(:position)
  end
end
