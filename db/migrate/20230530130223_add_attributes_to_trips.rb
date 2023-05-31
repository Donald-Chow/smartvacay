class AddAttributesToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :lng, :float
    add_column :trips, :lat, :float
    add_column :trips, :driving, :boolean, default: false
  end
end
