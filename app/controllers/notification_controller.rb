class NotificationController < ApplicationController
  skip_before_action :authorize_request, only: [:index]

  def protect_against_forgery?
    false
  end

  def index
    require 'net/http'
    require 'uri'
    params = {"app_id" => "46f73879-5b3e-45a0-90de-91f455b65eb4",
              "contents" => {"en" => "Accepted friend request"},
              "filters" => [{"field": "tag", "key": "User_Id", "relation": "=", "value": "2"}]
              #"filters" => [{"field": "tag", "key": "User_Id", "relation": "=", "value": @friend_id}]
    }
    uri = URI.parse('https://onesignal.com/api/v1/notifications')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.path,
                                  'Content-Type'  => 'application/json;charset=utf-8',
                                  'Authorization' => "Basic YzQ4ZGQ1MjktNmY1Ni00YTc5LTk0NDAtNDJiMzUxZjUyNTEz")
    request.body = params.as_json.to_json
    response = http.request(request)
    puts response.body
  end
end
