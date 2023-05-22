class Itinerary < ApplicationRecord
  belongs_to :trip
  belongs_to :user, through: :trip
  belongs_to :location
end
