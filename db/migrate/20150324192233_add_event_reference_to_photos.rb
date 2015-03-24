class AddEventReferenceToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :event, index: true
  end
end
