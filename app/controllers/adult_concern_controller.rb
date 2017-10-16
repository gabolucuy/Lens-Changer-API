class AdultConcernController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getAdultConcern]
    
        def create
            adult_concern= AdultConcern.create(adult_concern_params)        
            response = { message: "Adult Concern agregado!" }
            json_response(response)
        end
    
        
        def getAdultConcern
            @adult_concern = AdultConcern.where(id: params[:adult_concern_id])        
            json_response(@adult_concern)
        end
    
        private
    
        def adult_concern_params
            params.permit(
                :description,
                :unsolved_problem_id,            
                )
        end    
end
