class SolutionPairsController < ApplicationController
    skip_before_action :authorize_request, only: [:create]
    
    def index
        @solution_pairs = current_user.solution_pairs 
        render json: @solution_pairs, each_serializer: SolutionPairSerializer
    end

    def create
        data =  JSON.parse(params[:data])
        response = ""
        data.each do |json_up|
            
            response = create_solution_pair(json_up,params[:user_id],params[:child_id],params[:posible_solution_id],params[:unsolved_problem_id])
        end
        json_response(response)
    end

    def create_solution_pair(json_up,user_id,child_id,posible_solution_id,unsolved_problem_id)
        api_child = Child.where("child_id = ? AND user_id = ?",child_id, user_id ).first
        unsolved_problems_api = User.find(user_id).children.find_by_child_id(child_id).unsolved_problems.find_by_unsolved_problem_id_app(unsolved_problem_id)
        api_posible_solution = unsolved_problems_api.posible_solutions.find_by_posible_solution_id(posible_solution_id)
        

        api_solution_pairs = SolutionPair.where("child_id = ? AND user_id = ? AND posible_solution_id = ?",api_child.id,user_id,api_posible_solution.id).first 

        if api_solution_pairs != nil
            if api_solution_pairs.update(
                :description => json_up["description"],
                :description2 => json_up["description2"],
                :solution_id => json_up["solution_id"], 
                )
                response = { message: "Solution pair updated successfully"}
            else
                response = { message: "Error, solution pair was not updated successfully"}
            end
        else
            solution_pair = SolutionPair.new(
                :description => json_up["description"],
                :description2 => json_up["description2"],
                :solution_id => json_up["solution_id"], 
                :user_id => user_id,
                :child_id => api_child.id,
                :posible_solution_id => api_posible_solution.id )
                if solution_pair.save
                    response = { message: "Solution pair created successfully"}
                else
                    response = { message: "Error, solution pair was not created successfully"}
                end
        end
        return response
    end
    def protect_against_forgery?
        false
    end
    private

    def solution_pairs_params
        params.permit(
        :description,
        :description2,
        :solution_id,
        :user_id,
        :child_id,
        :unsolved_problem_id,
        :posible_solution_id,
        :data,
        )
    end

end
