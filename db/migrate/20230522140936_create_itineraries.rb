class CreateItineraries < ActiveRecord::Migration[7.0]
  def change
    create_table :itineraries do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.datetime :start_time

      t.timestamps
    end
  end
end
