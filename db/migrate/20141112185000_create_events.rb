class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description, null:false
      t.decimal :distance, precision:5, scale:3
      t.datetime :event_date, null:false
      t.string :website, default: nil
      t.string :start_address, default: nil
      t.string :start_city, default: nil
      t.string :start_state, default: nil
      t.string :start_province, default: nil
      t.string :country, default: nil
      t.string :end_address
      t.string :end_city
      t.string :end_province
      t.string :end_state
      t.decimal :longitude, precision:14, scale:10, default:nil
      t.decimal :latitude, precision:14, scale:10, default:nil
      t.timestamps
    end
    add_index :events, [:description, :distance, :event_date], name: "event_info_index"
  end
end
