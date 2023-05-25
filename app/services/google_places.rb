require "uri"
require "net/http"
require "json"

class GooglePlaces
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def call
    key = ENV.fetch('GOOGLE_API_SERVER_KEY', nil)

    fields = ["name", "geometry", "formatted_address", "rating", "photos", "types", "place_id"].join("%2C")

    url = URI("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{query}&inputtype=textquery&fields=#{fields}&key=#{key}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    results = JSON.parse(response.read_body)["results"]
  end
end
