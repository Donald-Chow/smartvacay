require 'kmeans-clusterer'

class TripGenerator
  attr_reader :locations

  def initialize(locations)
    @locations = locations
  end

  def make_itin
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

    k = 2 # Optimal K found using the elbow method
    groupings = KMeansClusterer.run k, data, labels:, runs: 100

    days = groupings.clusters
    grouped_location = {}
    day = 1
    days.each do |day|
      grouped_location["#{day}"] =
        day.points.map do |c|
          Location.find(c.label)
        end
    end

    return days
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
end
