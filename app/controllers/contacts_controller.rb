class ContactsController < ApplicationController
    skip_before_action :authorize_request, only: []

    def create

    end

    def index
      @user_frineds = current_user.friends
      render json: @user_frineds
    end

    def protect_against_forgery?
      false
    end

    def destroy
      contact = Contact.where("user_id = ? AND friend_id = ?",params[:user_id],params[:id]).first
      friend =  Contact.where("user_id = ? AND friend_id = ?",params[:id],params[:user_id]).first
      friend.destroy
      contact.destroy
      response = { message: "Contact deleded",status: "Succes"}
      json_response(response)
    end

    private

    def contact_params
      params.permit(
      :user_id,
      :friend_id
      )
    end

end
