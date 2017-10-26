class PosibleSolutionController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :getChildConcern, :index]

      def index
        @posible_solutions = PosibleSolution.where("user_id = ?, unsolved_problem_id = ?" ,params[:user_id, :unsolved_problem_id])
        json_response(@posible_solutions)
      end

      def create
        data =  JSON.parse(params[:data])
        user_id = params[:user_id]
        child_id = params[:child_id]
        unsolved_problem_id = params[:unsolved_problem_id]
        response = ""
        data.each do |json_up|
            response = create_posible_solution(json_up,user_id,child_id,unsolved_problem_id)
        end
        json_response(response)
      end

      def create_posible_solution(json_up,user_id,child_id,unsolved_problem_id)
          puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--------------@@@@@@@@@@@@@@@"
          api_up = User.find(user_id).children.find_by_child_id(child_id).unsolved_problems.find_by_unsolved_problem_id_app(unsolved_problem_id)
          puts "CREATE:" + api_up.description          
          
          solution_id = json_up["id"]
          solution_description = json_up["description"]
          solution_raitng = json_up["rating"]
          solution_unsolved_problem_id =json_up["unsolved_problem_id"]

          unsolved_problems_api = User.find(user_id).children.find_by_child_id(child_id).unsolved_problems.find_by_unsolved_problem_id_app(unsolved_problem_id)
          api_posible_solution = unsolved_problems_api.posible_solutions.find_by_posible_solution_id(solution_id)
          if api_posible_solution != nil
              if api_posible_solution.update(
                    :rating => solution_raitng,
                    :description => solution_description)
                    response = { message: "Posible Solution updated successfully"}
              else
                    response = { message: "Error, Posible Solution was not updated successfully"}
              end
          else
              posible_solution = PosibleSolution.new( 
                  :posible_solution_id => solution_id,
                  :rating => solution_raitng,
                  :description => solution_description,
                  :unsolved_problem_id => unsolved_problems_api.id)
              if posible_solution.save
                response = { message: "Posible Solution created successfully"}
                else
                  response = { message: "Error, Posible Solution was not created successfully"}
                end
              end
          return response
      end

      def getPosibleSolution
          @posible_solution = PosibleSolution.where(id: params[:posibleSolution_id])
          json_response(@posible_solution)
      end
      def protect_against_forgery?
          false
      end
end
