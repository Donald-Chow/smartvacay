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

    url = URI("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{query}&inputtype=textquery&radius=10000&fields=#{fields}&key=#{key}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    results = JSON.parse(response.read_body)["results"]
    return results
  end

  def details
    key = ENV.fetch('GOOGLE_API_SERVER_KEY', nil)

    # fields = ["website", "formatted_phone_number", "editorial_summary", "name", "geometry", "formatted_address", "rating",
    #           "photos", "types", "place_id", "reviews", "opening_hours", "price_level"].join("%2C") &fields=#{fields}

    url = URI("https://maps.googleapis.com/maps/api/place/details/json?place_id=#{query}&key=#{key}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    # puts response.read_body
    result = JSON.parse(response.read_body)["result"]
    # puts result
    return result
  end

  def geocode
    key = ENV.fetch('GOOGLE_API_SERVER_KEY', nil)

    url = URI("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{query}&inputtype=textquery&fields=geometry&key=#{key}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    puts response.read_body

    JSON.parse(response.read_body)['candidates'][0]['geometry']['location']
  end
end
