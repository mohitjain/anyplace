# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create(email: 'admin@anyplace.com', password: 'password')

10.times.each do
  User.create(
    name: Faker::GameOfThrones.character,
    email: Faker::Internet.email,
    password: "test@anyplace",
  )
end

50.times.each do
  hotel = Hotel.create(
    name: Faker::GameOfThrones.house,
    address: Faker::Address.full_address,
    description: Faker::GameOfThrones.quote,
  )

  [1,2].sample.times.each do
    RoomType.create(
      hotel_id: hotel.id,
      name: Faker::GameOfThrones.dragon,
      occupancy_limit: (5..10).to_a.sample,
    )
  end
  hotel.reload
  60.times.each do |index|
    hotel.room_types.each do |room_type|
      Pricing.create(
        room_type_id: room_type.id,
        price_date: (Date.today + index),
        price: [50, 60, 70, 80, 90, 100].sample,
      )
    end
  end

  60.times.each do |index|
    hotel.room_types.each do |room_type|
      Availability.create(
        room_type_id: room_type.id,
        availability_date: (Date.today + index),
        available_rooms: room_type.occupancy_limit,
      )
    end
  end
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
