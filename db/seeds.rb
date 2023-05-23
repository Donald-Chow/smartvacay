# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# user@wagon.com
# secret

Location.destroy_all

10.times do
  location = Location.new(
    name: Faker::Address.secondary_address
  )
  location.save
  puts "Location ID #{location.id} has been created."
end
