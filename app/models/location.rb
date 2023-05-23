class Location < ApplicationRecord
  has_many :itineraries
  has_many :trips, through: :itineraries
  has_many :users, through: :trips

  acts_as_favoritable
end
