class AddOrderToItineraries < ActiveRecord::Migration[7.0]
  def change
    add_column :itineraries, :order, :integer
    add_column :itineraries, :date, :date
  end
end
