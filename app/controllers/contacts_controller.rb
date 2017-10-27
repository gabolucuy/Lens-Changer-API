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

    private

    def contact_params
      params.permit(
      :user_id,
      :friend_id
      )
    end
end
