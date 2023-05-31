class ItinerariesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    Itinerary.new
  end

  def update
    params["array"].each_with_index do |item, index|
      date_id = item.split("|")
      itinerary = Itinerary.find(date_id[1])
      itinerary.date = date_id[0].to_date
      itinerary.order = index
      itinerary.save
      authorize itinerary
    end
    render json: { status: "ok" }
  end

  # def update_all
  #   puts params["array"]
  #   debugger

  #   @Itinerary = Itinerary.all
  #   authorize @itinerary

  # end

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
