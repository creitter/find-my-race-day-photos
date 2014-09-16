json.array!(@locations) do |location|
  json.extract! location, :id, :description, :geo_tag, :longitude, :latitude
  json.url location_url(location, format: :json)
end
