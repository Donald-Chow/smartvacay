class Location < ApplicationRecord
  has_many :itineraries
  has_many :trips, through: :itineraries
  has_many :users, through: :trips

  # validates :place_id, precense: true, uniqueness: true
  # validates :name, precense: true

  acts_as_favoritable
end
