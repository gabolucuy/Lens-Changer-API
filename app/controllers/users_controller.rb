class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :activate_user]
  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    user.update(:is_activated => "0")
    ConfirmationMailer.verification_send(user).deliver_now
    #NotificationMailer.notify_new_company_request(@company).deliver_now      
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end  

  def activate_user
    #email = params[:email]
    #user = user_params
    u = User.where(email: "dany.gaara.ds@gmail.com" )
    u.update(:is_activated => "1")
    ConfirmationMailer.user_activated(u).deliver_now
  end


  def me
    render json: current_user
  end

  def search
    users = User.all.where("email LIKE ? AND id != ?","%#{params[:search_options]}%",current_user.id)
    render json:users
  end

  def protect_against_forgery?
    false
  end

  private

  def user_params
    params.permit(
    :name,

    :last_name,
    :email,
    :phone,
    :password,
    :password_confirmation,
    :search_optionspedo
    )
  end

end
