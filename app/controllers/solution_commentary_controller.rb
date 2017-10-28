class SolutionCommentaryController < ApplicationController
	skip_before_action :authorize_request, only: [:create, :index]
	def index
		unsolved_problems_api = User.find(params[:user_id]).children.find_by_child_id(params[:child_id]).unsolved_problems.find_by_unsolved_problem_id_app(params[:unsolved_problem_id])
		api_posible_solution = unsolved_problems_api.posible_solutions.find_by_posible_solution_id(params[:posible_solution_id])
		@api_solution_comentary = api_posible_solution.solution_commentaries
		json_response(@api_solution_comentary)
	end

	def create
        data =  JSON.parse(params[:data])
        user_id = params[:user_id]
        child_id = params[:child_id]
        unsolved_problem_id = params[:unsolved_problem_id]
        solution_id = params[:solution_id]
        puts "-----------------------JSON----------------"
        puts data
        puts user_id
        puts child_id
        puts unsolved_problem_id
        puts solution_id
        response = ""

        data.each do |json_up|
            response = create_solution_commentary(json_up,user_id,child_id,unsolved_problem_id,solution_id)
        end
        json_response(response)
	end

    def create_solution_commentary(json_up,user_id,child_id,unsolved_problem_id,solution_id)
      solution_commentary_id = json_up["id"]
      solution_commentary_id_description = json_up["description"]
      solution_commentary_commented_at = json_up["commented_at"]

      unsolved_problems_api = User.find(user_id).children.find_by_child_id(child_id).unsolved_problems.find_by_unsolved_problem_id_app(unsolved_problem_id)
      api_posible_solution = unsolved_problems_api.posible_solutions.find_by_posible_solution_id(solution_id)
      api_solution_comentary = api_posible_solution.solution_commentaries.find_by_solution_commentary_id_app(solution_commentary_id)

      if api_solution_comentary != nil
          if api_solution_comentary.update(
                :rating => solution_raitng,
                :description => solution_description)
                response = { message: "Solution commentary updated successfully"}
          else
                response = { message: "Error, Solution commentary was not updated successfully"}
          end
      else
          solution_comentary = SolutionCommentary.new(
              :solution_commentary_id_app => solution_commentary_id,
              :commented_at => solution_commentary_commented_at,
              :description => solution_commentary_id_description,
              :posible_solution_id => api_posible_solution.id)

          if solution_comentary.save
            response = { message: "Solution commentary created successfully"}
            else
              response = { message: "Error, Solution commentary was not created successfully"}
            end
          end

      return response
    end



    def protect_against_forgery?
        false
    end

	private
    def solution_commentary_params
        params.permit(
        :solution_id,
        :user_id,
        :child_id,
        :data
              )
    end

end
