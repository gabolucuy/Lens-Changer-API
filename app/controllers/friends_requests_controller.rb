class FriendsRequestsController < ApplicationController
  skip_before_action :authorize_request, only: []

  def create
    contact = Contact.where("user_id = ? AND friend_id = ?",params[:user_id],params[:applicant_id])
    if contact.count > 0
      response = { message: "The person is already in your contacts list",status: "Error"}
    else
      pending_request = FriendsRequest.where("user_id = ? AND applicant_id = ?",params[:applicant_id],params[:user_id])
      if pending_request.count > 0
        response = { message: "You have a pending friend request from this person",status: "Error"}
      else
        request = FriendsRequest.create(friends_request_params)
        if request.save
            user_create = User.find(params[:user_id])
            text = "You have a friend request from " + user_create.name + " " + user_create.last_name
            notifications(params[:applicant_id], text)

          response = { message: "A friend request has been sent to the person",status: "Succes"}
        else
            response = { message: "You already sent a friend request to the person",status: "Error"}
        end
      end
    end
    json_response(response)
  end

  def index
    render json:FriendsRequest.where("applicant_id = ?",current_user.id), each_serializer: FriendsRequestSerializer
  end

  def accept
    @friend_request=FriendsRequest.find(params[:id])
    @user_id = @friend_request.user_id
    @friend_id = @friend_request.applicant_id
    contact = Contact.new
    contact.user_id = @user_id
    contact.friend_id = @friend_id
    contact1 =Contact.new
    if contact.save
      contact1.user_id = @friend_id
      contact1.friend_id = @user_id
      # # mandando notificaciones
      #user_accept = User.find(@friend_id)
      #text =  user_accept.name + " " + user_accept.last_name + " accepted your friend request"
      text =  "accepted your friend request"
      notifications(@user_id,text)

      contact1.save
      response = { message: "Friend request has been accepted",status: "Succes"}
    else
        response = { message: "The person is already in your contacts list ",status:"Error"}
    end
    request = FriendsRequest.find(params[:id])
    request.delete
    json_response(response)
  end
  def getPendingRequests
    @applicant_ids = FriendsRequest.select('applicant_id').where("user_id = ?",params[:user_id])
    if @applicant_ids.length > 0
      @finalResponse = User.where("id = ?",@applicant_ids.first.applicant_id)
      puts @applicant_ids.first.applicant_id
      @applicant_ids.drop(1).each do |a|
        puts a.applicant_id
        @firstResponse = User.where("id = ?",a.applicant_id)
        @finalResponse = @finalResponse + @firstResponse
      end
      render json:@finalResponse
    end
  end
  def reject
    response = { message: "Friend request rejected",status:"Succes"}
    request = FriendsRequest.find(params[:id])
    request.delete
    json_response(response)
  end

  def protect_against_forgery?
    false
  end

  def notifications(value, text)
    require 'net/http'
    require 'uri'
    params = {"app_id" => "46f73879-5b3e-45a0-90de-91f455b65eb4",
              "contents" => {"en" => text},
              "filters" => [{"field": "tag", "key": "User_Id", "relation": "=", "value": value}]
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

  private

  def friends_request_params
    params.permit(
    :user_id,
    :applicant_id,
    :friend_id
    )
  end

end
