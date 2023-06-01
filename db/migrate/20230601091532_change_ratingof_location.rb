class ChangeRatingofLocation < ActiveRecord::Migration[7.0]
  def change
    change_column :locations, :rating, :integer, default: 0
  end
end
