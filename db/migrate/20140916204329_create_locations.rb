class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :description
      t.decimal :longitude, precision:14, scale:10
      t.decimal :latitude, precision:14, scale:10
      t.decimal :altitude, precision:14, scale:10
      t.decimal :image_direction, precision:14, scale:10

      t.timestamps
    end
  end
end
