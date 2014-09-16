json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :ip_address
  json.url user_url(user, format: :json)
end
