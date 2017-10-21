class UnsolvedProblemController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getUnsolvedProblem]

    	def create
            unsolved_problem = UnsolvedProblem.new(unsolved_problem_params)
            api_child = Child.where(child_id: unsolved_problem_params[:child_id])     
            if api_child.count < 1
                response = { message: "Error, child is not in database"}
                json_response(response)
            else
                unsolved_problem.child_id =  api_child.first.id 
                if unsolved_problem.save
                    response = { message: "Unsolved Problem created"}       
                    json_response(response)
                else
                    response = { message: "Error, no Unsolved Problem created"}
                    json_response(response)
                end            
            end          
      	end

        def getUnsolvedProblem
            @unsolved_problem = UnsolvedProblem.where(id: params[:unsolved_problem_id])
            json_response(@unsolved_problem)
            
        end

        def protect_against_forgery?
            false
        end

        private

    	def unsolved_problem_params
            params.permit(
            :description,
            :solved,
            :unsolved_order,
            :unsolved_score,
            :user_id,
            :child_id
                )
        end
end
