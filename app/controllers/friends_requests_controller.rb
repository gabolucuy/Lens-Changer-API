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
    render json:current_user.friends_requests
  end

  def accept

  end

  def reject

  end

  def protect_against_forgery?
    false
  end

  private

  def friends_request_params
    params.permit(
    :user_id,
    :applicant_id
    )
  end
end
