require 'kmeans-clusterer'

class TripGenerator
  attr_reader :locations, :trip

  def initialize(locations, trip)
    @locations = locations
    @trip = trip
  end

  def call
    trip.itineraries.destroy_all
    # fl = user.favorited_location
    # sl = fl.sort_by do |location|
    #   Geocoder::Calculations.distance_between(user_location, location.coordinates)
    # end

    # # Use K-means clustering to group the locations based on proximity
    # kmeans = KMeansClusterer.run(favorited_locations, clusters: 3, runs: 10) # Adjust the number of clusters and runs as per your needs

    # # Sort the locations within each cluster based on proximity
    # sorted_locations = []
    # kmeans.clusters.each do |cluster|
    #   sorted_cluster_locations = cluster.points.sort_by do |location|
    #     Geocoder::Calculations.distance_between(cluster.centroid, location.coordinates)
    #   end
    #   sorted_locations += sorted_cluster_locations
    # end
    # sorted_locations += sorted_cluster_locations

    data = []
    labels = []
    # Load data from CSV file into two arrays - one for latitude and longtitude data and one for labels
    locations.each do |location|
      labels.push(location.id)
      data.push([location.latitude, location.longitude])
    end
    k = 1
    # k = (trip.end_date - trip.start_date).to_i # Optimal K found using the elbow method
    groupings = KMeansClusterer.run k, data, labels:, runs: 100

    days = groupings.clusters
    days.each do |day|
      date = trip.start_date + day.id.to_i
      day_locations = []
      day.points.each do |c|
        day_locations << Location.find(c.label)
      end
      create_day(day_locations, date)
    end

    # kmeans.clusters.map do |cluster|

    #   cluster.points.each do |element|

    #   # p cluster.points
    #   # puts "Cluster #{cluster.id}"
    #   # puts "Center of Cluster: #{cluster.centroid}"
    #   # cluster.points.map { |c| Location.find(c.label.to_i) }

    #   # puts "Cities in Cluster: " + cluster.points.join(",")
    # end
    # return kmeans.clusters
  end

  # day_locations should be an array of location instance
  # HOW TO PARSE THIS!

  def create_day(day_locations, date)
    set_restaurants(day_locations, date)
    set_attractions(day_locations, date)
  end

  def set_restaurants(day_locations, date)
    # select if location category is restaruant
    restaurants = day_locations.select do |location|
      location.type_of_place.split(", ").include? "restaurant"
    end
    # lunch
    restaurant = restaurants.sample
    create_itin(restaurant, date, 12)
    # Dinner
    restaurants.delete(restaurant)
    restaurant = restaurants.sample
    create_itin(restaurant, date, 19)
  end

  def set_attractions(day_locations, date)
    # select if location category not restaurant
    attractions = day_locations.reject do |location|
      location.type_of_place.split(", ").include? "restaurant"
    end
    # morning
    attraction = attractions.sample
    create_itin(attraction, date, 9)
    # afternoon
    attractions.delete(attraction)
    attraction = attractions.sample
    create_itin(attraction, date, 15)
  end

  def create_itin(type, date, hour)
    item = Itinerary.new(
      location: type,
      trip:,
      start_time: DateTime.new(date.year, date.mon, date.mday, hour, 0, 0)
    )
    item.save
  end
end

# Itinerary.new(
#   location: Location.find(day.points[0].label),
#   trip:,
#   start_time: DateTime.new(date.year, date.mon, date.mday, 9, 0, 0)
# )
