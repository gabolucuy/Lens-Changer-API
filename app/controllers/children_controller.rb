class ChildrenController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getChild]    
    
        def create
            #if(User.find(params[:user_id]))
                child = Child.create!(child_params)                
                response = { message: "Child created"}
                json_response(response)
            #else
             #   response = { message: "Child created"}
              #  json_response(response)
            #end    
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
                :user_id            
                )
        end    
end
