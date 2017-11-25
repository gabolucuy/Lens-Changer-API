class ActivationController < ApplicationController
  skip_before_action :authorize_request, only: [:show] 
  def show
    @model_object = User.where(email: "dany.gaara.ds@gmail.com")
    
    respond_to do |format|
      #format.json { render :json => @model_object }
      format.html # index.html.erb
    end  
  end

  def protect_against_forgery?
    false
  end
end
