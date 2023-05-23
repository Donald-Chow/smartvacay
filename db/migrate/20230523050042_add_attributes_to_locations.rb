class AddAttributesToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :place_id, :string
    add_column :locations, :address, :string
    add_column :locations, :phone, :string
    add_column :locations, :website, :string
    add_column :locations, :rating, :integer
    add_column :locations, :review, :text
    add_column :locations, :photo, :string
    add_column :locations, :opening_hours, :string
    add_column :locations, :price_level, :integer
    add_column :locations, :amenities, :string
    add_column :locations, :type_of_place, :string
    add_column :locations, :geometry, :string
    add_column :locations, :duration, :integer
    add_column :locations, :description, :text
  end
end
