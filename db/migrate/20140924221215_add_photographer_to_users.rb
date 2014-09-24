class AddPhotographerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photographer, :boolean
  end
end
