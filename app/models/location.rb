class Location < ApplicationRecord
  has_many :itineraries
  has_many :trips, through: :itineraries
  has_many :users, through: :trips

  # validates :place_id, precense: true, uniqueness: true
  # validates :name, precense: true

  acts_as_favoritable

  def self.google_create(location)
    Location.create(
      name: location["name"],
      place_id: location["place_id"],
      address: location["formatted_address"] || "",
      phone: location['"formatted_phone_number"'],
      website: location['website'],
      rating: location["rating"],
      review: location['reviews'],
      # photo: if location.include?("photos")
      #          "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=#{location['photos'][0]['photo_reference']}&key=#{ENV.fetch(
      #            'GOOGLE_API_SERVER_KEY', nil
      #          )}"
      #        else
      #          "http://source.unsplash.com/featured/?Tokyo&#{rand(1000)}"
      #        end,
      photo: if location.include?("photos")
               photos = location['photos'].map { |photo| photo['photo_reference'] }
               photos = photos.map do |photo|
                 "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=#{photo}&key=#{ENV.fetch(
                   'GOOGLE_API_SERVER_KEY', nil
                 )}"
               end
               if photos.count < 5
                 photos = photos.join(",")
               else
                 photos = photos[0..3].join(",")
               end
               photos
             else
               "http://source.unsplash.com/featured/?#{location['name']}&#{rand(1000)}"
             end,
      opening_hours: location['opening_hours'] ? location['opening_hours']['weekday_text'] : nil,
      price_level: location['price_level'],
      type_of_place: location['types'].join(", "),
      geometry: location['geometry'],
      description: location['editorial_summary'] ? location['editorial_summary']['overview'] : nil,
      latitude: location['geometry']["location"]["lat"],
      longitude: location['geometry']["location"]["lng"],
      category: if type_of_place.include?("restaurant") || type_of_place.include?("meal_takeaway") || type_of_place.include?("food")
                  "food"
                elsif type_of_place.include?("department_store") || type_of_place.include?("shopping_mall")
                  "shopping"
                elsif type_of_place.include?("tourist_attraction")
                  "sightseeing"
                else
                  "miscellaneous"
                end
    )
  end
end
