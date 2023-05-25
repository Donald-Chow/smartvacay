# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"
require "json"

type_of_places = ["tourist_attraction", "restaurant", "department_store"]

puts "Cleaning database..."
Itinerary.destroy_all
Location.destroy_all

puts "Creating Test Locations"

type_of_places.each do |place|
  url = "https://maps.googleapis.com/maps/api/place/textsearch/json?type=#{place}&language=en&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
  response = URI.open(url).read
  parsed_response = JSON.parse(response)
  # puts parsed_response
  parsed_response['results'].each do |result|
    Location.create!(
      name: result["name"],
      place_id: result["place_id"],
      address: result["formatted_address"],
      phone: result["formatted_phone_number"],
      website: result["website"],
      rating: result["rating"],
      # review:
      # photo:
      # opening_hours:
      # price_level:
      # amenities:
      type_of_place: result["types"].join(", "),
      geometry: "lat: #{result['geometry']['location']['lat']}, lng: #{result['geometry']['location']['lng']}",
      latitude: result['geometry']['location']['lat'],
      longitude: result['geometry']['location']['lng']
      # duration:
      # description:
    )
  end
end

# Location.create(
#   name: "Tokyo Skytree 2",
#   place_id: 'ChIJN1t_tDeuEmsRUsoyG83frY4',
#   address: '1 Chome-1-2 Oshiage, Sumida City, Tokyo 131-0045, Japan',
#   phone: "0570-550-634",
#   website: "http://www.tokyo-skytree.jp/",
#   rating: 5,
#   review: "Absolutely stunning!\n\nThe surrounding area was perfect during summer.",
#   photo: 'https://lh5.googleusercontent.com/p/AF1QipO9sg1RHEe7tDbrXPUz0HTy14J_uS-TogiG6_MD=w408-h544-k-no',
#   opening_hours: 'Monday to Friday 9am-5pm',
#   price_level: 3,
#   amenities: "Wi-Fi, parking, restaurants, observation decks, shops.",
#   type_of_place: "point_of_interest",
#   geometry: "lat: 35.7101, lng: 139.8107",
#   latitude: 35.7121,
#   longitude: 139.8137,
#   duration: 2,
#   description: "World's tallest freestanding broadcasting tower with an observation deck boasting 360-degree views."
# )

# Location.create(
#   name: "Tokyo Skytree 3",
#   place_id: 'ChIJN1t_tDeuEmsRUsoyG83frY4',
#   address: '1 Chome-1-2 Oshiage, Sumida City, Tokyo 131-0045, Japan',
#   phone: "0570-550-634",
#   website: "http://www.tokyo-skytree.jp/",
#   rating: 5,
#   review: "Absolutely stunning!\n\nThe surrounding area was perfect during summer.",
#   photo: 'https://lh5.googleusercontent.com/p/AF1QipO9sg1RHEe7tDbrXPUz0HTy14J_uS-TogiG6_MD=w408-h544-k-no',
#   opening_hours: 'Monday to Friday 9am-5pm',
#   price_level: 3,
#   amenities: "Wi-Fi, parking, restaurants, observation decks, shops.",
#   type_of_place: "point_of_interest",
#   geometry: "lat: 35.7101, lng: 139.8107",
#   latitude: 35.7221,
#   longitude: 139.8037,
#   duration: 2,
#   description: "World's tallest freestanding broadcasting tower with an observation deck boasting 360-degree views."
# )

# Location.create(
#   name: "Tokyo Skytree 4",
#   place_id: 'ChIJN1t_tDeuEmsRUsoyG83frY4',
#   address: '1 Chome-1-2 Oshiage, Sumida City, Tokyo 131-0045, Japan',
#   phone: "0570-550-634",
#   website: "http://www.tokyo-skytree.jp/",
#   rating: 5,
#   review: "Absolutely stunning!\n\nThe surrounding area was perfect during summer.",
#   photo: 'https://lh5.googleusercontent.com/p/AF1QipO9sg1RHEe7tDbrXPUz0HTy14J_uS-TogiG6_MD=w408-h544-k-no',
#   opening_hours: 'Monday to Friday 9am-5pm',
#   price_level: 3,
#   amenities: "Wi-Fi, parking, restaurants, observation decks, shops.",
#   type_of_place: "point_of_interest",
#   geometry: "lat: 35.7101, lng: 139.8107",
#   latitude: 35.7231,
#   longitude: 139.8097,
#   duration: 2,
#   description: "World's tallest freestanding broadcasting tower with an observation deck boasting 360-degree views."
# )
# Location.create(
#   name: "Tokyo Skytree 5",
#   place_id: 'ChIJN1t_tDeuEmsRUsoyG83frY4',
#   address: '1 Chome-1-2 Oshiage, Sumida City, Tokyo 131-0045, Japan',
#   phone: "0570-550-634",
#   website: "http://www.tokyo-skytree.jp/",
#   rating: 5,
#   review: "Absolutely stunning!\n\nThe surrounding area was perfect during summer.",
#   photo: 'https://lh5.googleusercontent.com/p/AF1QipO9sg1RHEe7tDbrXPUz0HTy14J_uS-TogiG6_MD=w408-h544-k-no',
#   opening_hours: 'Monday to Friday 9am-5pm',
#   price_level: 3,
#   amenities: "Wi-Fi, parking, restaurants, observation decks, shops.",
#   type_of_place: "point_of_interest",
#   geometry: "lat: 35.7101, lng: 139.8107",
#   latitude: 35.8231,
#   longitude: 139.8297,
#   duration: 2,
#   description: "World's tallest freestanding broadcasting tower with an observation deck boasting 360-degree views."
# )
# puts "... created #{Location.count} locations"

# puts "Cleaning database..."

# Location.destroy_all

# puts "Creating Test Locations"

# Location.create(
#     name: "Tokyo Skytree",
#     place_id: 'ChIJN1t_tDeuEmsRUsoyG83frY4',
#     address: '1 Chome-1-2 Oshiage, Sumida City, Tokyo 131-0045, Japan',
#     phone: "0570-550-634",
#     website: "http://www.tokyo-skytree.jp/",
#     rating: 5,
#     review: "Absolutely stunning!\n\nThe surrounding area was perfect during summer.",
#     photo: 'https://lh5.googleusercontent.com/p/AF1QipO9sg1RHEe7tDbrXPUz0HTy14J_uS-TogiG6_MD=w408-h544-k-no',
#     opening_hours: 'Monday to Friday 9am-5pm',
#     price_level: 3,
#     amenities: "Wi-Fi, parking, restaurants, observation decks, shops.",
#     type_of_place: "point_of_interest",
#     geometry: "lat: 35.7101, lng: 139.8107",
#     latitude: 35.7101,
#     longitude: 139.8107,
#     duration: 2,
#     description: "World's tallest freestanding broadcasting tower with an observation deck boasting 360-degree views."
# )


# Location.create(
#     place_id: "ChIJEX3XFIOOGGAR3XdJvRjWLyM",
#     name: "Tokyo National Museum",
#     address: "13-9 Uenokōen, Taito City, Tokyo 110-8712, Japan",
#     phone: "05055418600",
#     website: "https://www.tnm.jp/",
#     rating: 4.5,
#     review: "A really great museum with so much to see for a reasonable price. We paid 1000 Yen per person and felt like this was well worth the price. There are several buildings with multiple buildings which had a combination of artefacts, artworks, ceramics and more! Would highly recommend a visit and come early - the museum closes at 5pm and there is easily a good 4-5 hours worth of interesting exhibitions to see.",
#     photo: 'https://lh5.googleusercontent.com/p/AF1QipOdcI0YOhFPXbWougamUKE2GRGPHiXCbqhuzs_D=w408-h306-k-no',
#     opening_hours: 'Monday to Friday 9am-5pm',
#     price_level: 3,
#     amenities: "restaurants, toilets, good for kids.",
#     type_of_place: "point_of_interest",
#     geometry: "lat: 33.866489, lng: 151.1958561",
#     latitude: 35.6762,
#     longitude: 139.6503,
#     duration: 3,
#     description: "Stately museum complex devoted to the art & antiquities of Japan, as well as other Asian countries."
# )

# Location.create(
#     place_id: "ChIJp1Kx1dmMGGARvbZ_YYRx0vQ",
#     name: "Ichiran Shinjuku Kabuki-cho",
#     address: "160-0022 Tokyo, Shinjuku City, Shinjuku, 3 Chome−34−11, Peace Bldg., B1F",
#     phone: "0332255518",
#     website: "ichiran.com",
#     rating: 4.3,
#     review: "This location was my first time ever eating Ichiran and it did not disappoint! Broth was super rich and flavorful. Noodles taste super authentic and have amazing texture. Only minor issue is they don\u2019t give you enough noodles but for like 200 yen, you can order extra! Meat and toppings are excellent. Love the flexibility and easiness of adjusting your bowl and toppings. Ordering from machine is super friendly since they have English option. Isolated seating is nice and cool concept. Staff was super friendly and helpful. I ate at several other locations and they all were excellent! Highly recommend, but do expect longer wait times but definitely worth the wait.",
#     photo: 'https://lh3.googleusercontent.com/p/AF1QipNdP7Dan-4shFm4BPOsYuIGtTbUDlsucZMbMStL=s1360-w1360-h1020',
#     opening_hours: '24 hours',
#     price_level: 3,
#     amenities: "toilets",
#     type_of_place: "meal_takeaway, restaurant, food",
#     geometry: "lat: 35.6944, lng: 139.7015",
#     latitude: 35.6944,
#     longitude: 139.7015,
#     duration: 1,
#     description: "Informal ramen restaurant with a specialty for tonkotsu ramen in a pork bone broth."
# )

# puts "... created #{Location.count} locations"
