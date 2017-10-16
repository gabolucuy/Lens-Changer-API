class ChildsController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getChild]    

    def create
        child = Child.create!(child_params)                
        response = { message: "Niño creado!"}
        json_response(response)
    end

    
    def getChild
        @child = Child.where(id: params[:child_id])        
        json_response(@child)
    end

    private

    def child_params
        params.permit(
            :name,
            :gender,
            :birthday,            
            )
    end    

    

end
