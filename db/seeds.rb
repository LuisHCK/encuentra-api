# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Seeding Database"

puts "#########################"

country = Country.new(iso: "NI", name: "Nicaragua", iso3: "NIC", latitude: 12.1328200, longitude: -86.2504000)
puts "Country Created!" if country.save

city = City.new(name: "Managua", iso: "MNG", country_id: country.id, latitude: 12.1328200, longitude: -86.2504000)
puts "City Created!" if city.save

zone = Zone.new(name: "Reparto Shick", city_id: city.id, latitude: 12.1328200, longitude: -86.2504000)
puts "Zone Created!" if zone.save
