# Create 100 rooms with random data

namespace :db do
  desc "Create 100 rooms with random data"
  task :seed_rooms => :environment do
    puts "Creating 100 fake rooms..."

    photos_path = Rails.root + "public/sample_photos/"
    photos = Dir.children(photos_path)

    100.times do
      room = Room.new(
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph(2),
        price: Faker::Number.leading_zero_number(3),
        lat: 12.1328200,
        lng: -86.2504000,
        address: Faker::Address.full_address,
        currency: "$",
        category: Category.first,
        zone: Zone.first,
        user: User.find_by(username: "encontracuarto"),
        services: %w(cocina baño sala internet\ 10mb seguridad entrada\ independiente),
        phones: %w(27151221 86014227),
      )

      index = SecureRandom.random_number(photos.size) - 1

      room.photos = [File.open(photos_path + photos[index])]

      if room.save()
        puts "Room #{room.id}- #{room.title} created!"
      else
        room.errors.each do |err|
          puts err
        end
      end
    end
  end
end
