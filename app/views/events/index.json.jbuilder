json.array!(@events) do |event|
  json.extract! event, :id, :description, :website, :distance, :event_date, :start_address, :start_city, :start_state, :start_province, :country, :end_address, :end_city, :end_province, :end_state, :longitude, :latitude
  json.url event_url(event, format: :json)
end
