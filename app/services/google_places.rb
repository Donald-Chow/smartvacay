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
    fields = "formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry"
    url = URI("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{query}&inputtype=textquery&fields=#{fields}&key=#{key}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    result = JSON.parse(response.read_body)

    # beatles = JSON.parse(response)
    return result
  end
end
