class UnsolvedProblemController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getUnsolvedProblem]

    	def create
            unsolved_problem = UnsolvedProblem.create(unsolved_problem_params)

            response = { message: "Unsolved Problem created"}
            json_response(response)
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
