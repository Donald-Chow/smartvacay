class Itinerary < ApplicationRecord
  belongs_to :trip
  belongs_to :location

  validates :start_time, presence: true
end
