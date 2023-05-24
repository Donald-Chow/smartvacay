class AddCategoryToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :category, :string
  end
end
