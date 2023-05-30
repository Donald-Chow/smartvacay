class UserReviewsController < ApplicationController
  before_action:set_location, only: %i[new create]

  def new
    @location = Location.find(params[:location_id])
    @user_review = UserReview.new
    authorize @user_review
  end

  def create
    @user_review = UserReview.new(user_review_params)
    @user_review.location = @location
    @user_review.save
    redirect_to location_path(@location)
    authorize @user_review
  end

  private

  def set_location
    @location = Location.find(params[:location_id])
  end

  def user_review_params
    params.require(:user_review).permit(:content)
  end

end
