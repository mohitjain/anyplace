# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times.each do
  User.create(
    name: Faker::GameOfThrones.character,
    email: Faker::Internet.email,
    password: "test@anyplace",
  )
end

50.times.each do
  Hotel.create(
    name: Faker::GameOfThrones.house,
    address: Faker::Address.full_address,
    description: Faker::Lorem.sentence,
  )
end
