require "uri"
require "net/http"

class GenerateToken
  def self.perform
    url = URI("https://dev-yto8hel8.eu.auth0.com/oauth/token")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = "application/json"
    request.body = "{\"client_id\":\"J7rHoji5WHs8ZIK3tVGQOG50RiU4hXWY\",\"client_secret\":\"9Er6EWM376Uj7DQHvtSQYIj4tDJGiRASi0GoHHblUwI5Wi8wjiSx8iFTcj-u3SgP\",\"audience\":\"http://localhost:3000\",\"grant_type\":\"client_credentials\"}"

    response = http.request(request)

    return JSON.parse(response.read_body, symbolize_names: true)
  end
end
