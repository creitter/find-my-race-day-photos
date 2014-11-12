# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Event.delete_all
puts "All Events cleared"

Event.create(description: "Hot Chocolate", distance: 10, event_date: DateTime.new(2015,01,11), website: "www.hotchocolate15k.com",
start_address: "Golden Gate Music Concourse", start_city: "San Francisco", start_state: "CA", country: "US", 
end_address: "Golden Gate Music Concourse", end_city: "San Francisco", end_state: "CA")

Event.create(description: "Hot Chocolate", distance: 5, event_date: DateTime.new(2015,01,11),  website: "www.hotchocolate15k.com",
start_address: "Golden Gate Music Concourse", start_city: "San Francisco", start_state: "CA", country: "US", 
end_address: "Golden Gate Music Concourse", end_city: "San Francisco", end_state: "CA")

Event.create(description: "Avenue of the Giants", distance: 42.16, event_date: DateTime.new(2015,05,03), website: "http://www.theave.org/",
start_address: "Southern Humboldt County", start_city: "Eureka", start_state: "CA", country: "US", 
end_address: "", end_city: "", end_state: "CA", latitude: 40.35611, longitude:-123.923442)

Event.create(description: "Avenue of the Giants", distance: 21.08, event_date: DateTime.new(2015,05,03), website: "http://www.theave.org/",
start_address: "Southern Humboldt County", start_city: "Eureka", start_state: "CA", country: "US", 
end_address: "", end_city: "", end_state: "CA", latitude: 40.35611, longitude:-123.923442)

Event.create(description: "Avenue of the Giants", distance: 10, event_date: DateTime.new(2015,05,03), website: "http://www.theave.org/",
start_address: "Southern Humboldt County", start_city: "Eureka", start_state: "CA", country: "US", 
end_address: "", end_city: "", end_state: "CA", latitude: 40.35611, longitude:-123.923442)


puts "Events added: #{Event.all.count}"