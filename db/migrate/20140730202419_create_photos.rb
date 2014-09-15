class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :person
      t.integer :location
      t.string :tags
      t.string :note

      t.timestamps
    end
  end
end
