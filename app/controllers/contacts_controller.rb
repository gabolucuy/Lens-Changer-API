class ContactsController < ApplicationController
    skip_before_action :authorize_request, only: []

    def create
        contact = Contact.create(contact_params)
        contact1 =Contact.new
        if contact.save
          contact1.user_id = params[:friend_id]
          contact1.friend_id = params[:user_id]
          contact1.save
          response = { message: "Persona agregada a la lista de contactos"}
        else
            response = { message: "La persona que desea añadir ya se encuentra en su lista de contactos"}
        end
        json_response(response)
    end

  def index
    @user_frineds = current_user.friends
    render json: @user_frineds
  end

    def protect_against_forgery?
      false
    end

    private

    def contact_params
      params.permit(
      :user_id,
      :friend_id
      )
    end
end
