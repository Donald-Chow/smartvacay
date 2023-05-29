class Trip < ApplicationRecord
  belongs_to :user
  has_many :itineraries
  has_many :searches
  has_many :location, through: :itineraries
  has_many :searched_locations, through: :searches, source: :locations

  validates :destination, presence: true
  validates :start_date, presence: true
end
