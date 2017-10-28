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
          response = { message: "A friend request has been sent to the person",status: "Succes"}
        else
            response = { message: "You already sent before a friend request to the person",status: "Error"}
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
      contact1.save
      response = { message: "Friend request has been accepted",status: "Succes"}
    else
        response = { message: "The person is already in your contacts list ",status:"Error"}
    end
    request = FriendsRequest.find(params[:id])
    request.delete
    json_response(response)
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

  private

  def friends_request_params
    params.permit(
    :user_id,
    :applicant_id,
    :friend_id
    )
  end

end
