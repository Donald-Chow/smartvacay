require "uri"
require "net/http"
require "json"

class GoogleDirections
  attr_reader :origin, :destination, :dep_time, :mode

  def initialize(attributes = {})
    @origin = attributes[:origin]
    @destination = attributes[:destination]
    @dep_time = attributes[:dep_time]
    @mode = attributes[:mode] || "transit"
  end

  def call
    key = ENV.fetch('GOOGLE_API_SERVER_KEY', nil)
    # p key
    time = @dep_time.strftime('%s').to_i
    origin = "place_id:#{@origin.place_id}"
    destination = "place_id:#{@destination.place_id}"

    url = URI("https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&mode=#{@mode}&departure_time=#{time}&key=#{key}")
    # p url
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    # puts response.read_body
    if JSON.parse(response.read_body)["routes"].present?
      routes = JSON.parse(response.read_body)["routes"][0]['legs'][0]
    else
      routes = GoogleDirections.new(origin: @origin, destination: @destination, dep_time: @dep_time,
                                    mode: "walking").call
      # p routes
      # puts "distance is #{routes['distance']}"
      # puts "duration is #{routes['duration']}"
    end
    return routes
  end
end
