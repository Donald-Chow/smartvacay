class Search < ApplicationRecord
  belongs_to :location
  belongs_to :trip

  validates :location_id, presence: true
  validates :trip_id, presence: true

  category = ['top_attractions', 'top_restaurants', 'top_shoppings', 'user_searches']
  validates :category, inclusion: { in: category }
end
