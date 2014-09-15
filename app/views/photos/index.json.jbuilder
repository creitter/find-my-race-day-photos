json.array!(@photos) do |photo|
  json.extract! photo, :id, :person, :location, :tags, :note
  json.url photo_url(photo, format: :json)
end
