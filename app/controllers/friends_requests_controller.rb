class FriendsRequestsController < ApplicationController
  skip_before_action :authorize_request, only: []

  def create
    contact = Contact.where("user_id = ? AND friend_id = ?",params[:user_id],params[:applicant_id])
    if contact.count > 0
      response = { message: "La persona ya se encuentra en su lista de contactos"}
    else
      pending_request = FriendsRequest.where("user_id = ? AND applicant_id = ?",params[:applicant_id],params[:user_id])
      if pending_request.count > 0
        response = { message: "Ya tiene una solicitud de amistad pendiente de la otra persona"}
      else
        request = FriendsRequest.create(friends_request_params)
        if request.save
          response = { message: "Se mando una solicitud de amistad a la persona"}
        else
            response = { message: "Ya tiene una solicitud de amistad pendiente con la persona"}
        end
      end
    end
    json_response(response)
  end

  def index
    render json:FriendsRequest.where("applicant_id = ?",current_user.id)
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
      response = { message: "Persona agregada a la lista de contactos"}
    else
        response = { message: "La persona que desea añadir ya se encuentra en su lista de contactos"}
    end
    request = FriendsRequest.find(params[:id])
    request.delete
    json_response(response)
  end

  def reject
    response = { message: "Solicitud de amistad rechazada"}
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
