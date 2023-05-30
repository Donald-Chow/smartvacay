class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.references :location, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true
      t.string :category
      t.string :query

      t.timestamps
    end
  end
end
