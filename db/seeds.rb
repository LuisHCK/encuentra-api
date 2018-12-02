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

user = User.new(username: "luishck",
                email: "luisjcenteno17@gmail.com",
                name: "Luis",
                lastname: "Centeno",
                password: "ljco1800",
                password_confirmation: "ljco1800",
                country_id: country.id)

puts "User created!" if user.save
user.add_role(:admin)

city = City.new(name: "Managua", iso: "MNG", country_id: country.id, latitude: 12.1328200, longitude: -86.2504000)
puts "City Created!" if city.save

zone = Zone.new(name: "Reparto Shick", city_id: city.id, latitude: 12.1328200, longitude: -86.2504000)
puts "Zone Created!" if zone.save

category = Category.new(name: "Cuartos", code: "rooms")
puts "Category Created!" if category.save

room = Room.new(
  title: "Cuarto para estudiante",
  description: "Cuarto para estudiante con todos los serivicios",
  price: 100,
  lat: 12.1328200,
  lng: -86.2504000,
  address: "del juzgado 1c 1/2 al este",
  currency: "$",
  category: category,
  zone: zone,
  user: user,
)
puts "Room created!" if room.save

# Create 100 rooms with random data
puts "Creating 100 fake rooms..."
100.times do
  Room.create(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph(2),
    price: Faker::Number.leading_zero_number(3),
    lat: 12.1328200,
    lng: -86.2504000,
    address: Faker::Address.full_address,
    currency: "$",
    category: category,
    zone: zone,
    user: user,
  )
end
puts "End!!!!"
