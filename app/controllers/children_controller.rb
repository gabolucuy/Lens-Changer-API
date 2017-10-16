class ChildrenController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getChild]    
    
        def create
            if(Child.exists?(params[:id]))
                Child.update(params[:id], :name => params[:name], :gender => params[:gender], :birthday => params[:birthday], :user_id => params[:user_id])   
                response = { message: "Child Updated"}
                json_response(response)            
            else
              child = Child.create(child_params)                
              response = { message: "Child created"}
              json_response(response)
            end    
        end    
        
        def getChild
            @child = Child.where(id: params[:child_id])        
            json_response(@child)
        end

        def protect_against_forgery?
            false
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
