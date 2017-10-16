class UnsolvedProblemController < ApplicationController

	def create
    unsolved_problem = UnsolvedProblem.create!(unsolved_problem_params)
  	end


	def unsolved_problem_params
    params.permit(
    :description,
    :solved,
    :unsolved_order,
    :unsolved_score,
    :user_id
    )
  end
end
