require "net/http"
require "uri"

class JsonWebToken
  def self.verify(token)
    JWT.decode(token, nil,
               true,
               algorithm: "RS256",
               iss: ENV["DOMAIN"],
               verify_iss: true,
               aud: ENV["API_IDENTIFIER"],
               verify_aud: true) do |header|
      jwks_hash[header["kid"]]
    end
  end

  def self.jwks_hash
    jwks_raw = Net::HTTP.get URI("#{Rails.application.credentials.auth0[:domain]}.well-known/jwks.json")
    jwks_keys = Array(JSON.parse(jwks_raw)["keys"])
    Hash[
      jwks_keys
        .map do |k|
        [
          k["kid"],
          OpenSSL::X509::Certificate.new(
            Base64.decode64(k["x5c"].first)
          ).public_key,
        ]
      end
    ]
  end
end

# eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkFkSjFmWTA2WlhUTlJoSW5DbGl3aSJ9.eyJpc3MiOiJodHRwczovL2Rldi15dG84aGVsOC5ldS5hdXRoMC5jb20vIiwic3ViIjoiSjdySG9qaTVXSHM4WklLM3RWR1FPRzUwUmlVNGhYV1lAY2xpZW50cyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCIsImlhdCI6MTYwNzQxMTQzNCwiZXhwIjoxNjA3NDk3ODM0LCJhenAiOiJKN3JIb2ppNVdIczhaSUszdFZHUU9HNTBSaVU0aFhXWSIsImd0eSI6ImNsaWVudC1jcmVkZW50aWFscyJ9.V3Q8BcZ6AIaYGq-P6qrglh2vVTkQU88VzWWvQ7zuEuI0YKmnY_DOEl889q4Md5r4QAgPapkXL_eSJ3jXc2yoFMFb5FSk3-m4-3O7ITtyoORkfixQSNdyRbH--NSpQ5k0FIf48ZC_tw0X166LDSMdwU3l6TE-3U7il2uI5rjDoRv11oiXQ38ZhamP6V5yphp7ukLOyfHCHxR4d5u1ldmVqOF0ZvLA8eshU-zKdHrx5smTUPeljzD5K6E5rlCYq6UJrivUZ0rXEdrvYotkvi-1-K5eVgZmtTOivHefz2UOKD1V7X788xXTdl2x0iBhl1vU19MoPZfFuytILXToqVU2BQ
