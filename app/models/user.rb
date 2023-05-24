class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :trip
  has_many :itineraries, through: :trips
  has_many :location, through: :itineraries

  acts_as_favoritor
end
