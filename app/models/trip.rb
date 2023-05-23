class Trip < ApplicationRecord
  belongs_to :user
  has_many :itineraries
  has_many :location, through: :itineraries

  validates :destination, presence: true
end
