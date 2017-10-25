class ContactsController < ApplicationController
    skip_before_action :authorize_request, only: [:create]
    
    def create
        contact = Contact.create(contact_params)
        response = { message: "friend added to contact list"}
        json_response(response)
    end
  
   
  
    def protect_against_forgery?
      false
    end
  
    private
  
    def contact_params
      params.permit(
      :user_id
      :friend_id
      )
    end
end
