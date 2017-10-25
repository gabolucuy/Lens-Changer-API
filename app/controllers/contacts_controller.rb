class ContactsController < ApplicationController
    skip_before_action :authorize_request, only: [:create]
    
    def create
        contact = Contact.create(contact_params)
        if contact.save
            response = { message: "Persona agregada a la lista de contactos"}
        else
            response = { message: "La persona que desea añadir ya se encuentra en su lista de contactos"}
        end
        json_response(response)
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
