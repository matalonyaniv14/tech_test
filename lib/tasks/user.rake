# require_relative "../../config/application"
BASE_URL = "https://limitless-tor-81828.herokuapp.com"
CONTENT_TYPE = "Content-Type: application/json"

def update_user(sub_type, user_id, token)
  `curl -X PUT -H "#{CONTENT_TYPE}" -H "Authorization: bearer #{token}" -d '{ "subscription_type":"#{sub_type}"}' #{BASE_URL}/api/v1/users/#{user_id}`
end

namespace :user do
  task set_user_basic: :environment do
    token = GenerateToken.perform
    user = User.first
    puts update_user("basic", user.id, token[:access_token])
  end

  task set_user_premium: :environment do
    token = GenerateToken.perform
    user = User.first
    puts update_user("premium", user.id, token[:access_token])
  end

  task set_user_professional: :environment do
    token = GenerateToken.perform
    user = User.first
    puts update_user("professional", user.id, token[:access_token])
  end
end
