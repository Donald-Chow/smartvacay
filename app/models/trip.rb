class Trip < ApplicationRecord
  belongs_to :user
  has_many :itineraries, dependent: :destroy
  has_many :searches, dependent: :destroy
  has_many :location, through: :itineraries
  has_many :searched_locations, through: :searches, source: :locations

  validates :destination, presence: true
  validates :start_date, presence: true

  after_create :send_trip_email

  private

  def send_trip_email
    UserMailer.with(user: self.user).trip.deliver_later
  end
end
