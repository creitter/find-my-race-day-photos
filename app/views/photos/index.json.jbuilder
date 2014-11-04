json.array!(@photos) do |photo|
  json.extract! photo, :id, :user, :location, :tags, :note
  json.url photo_url(photo, format: :json)
end
