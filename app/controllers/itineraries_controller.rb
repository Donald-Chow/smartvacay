class ItinerariesController < ApplicationController
  def index
  end

  def create
    Itinerary.new
  end

  def update

  end

  def update_all
    raise
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    authorize @itinerary
    @itinerary.destroy
    redirect_to trip_path(@itinerary.trip)
  end

  private

  def todo_params
    params.require(:todo).permit(:start_time)
  end
end
