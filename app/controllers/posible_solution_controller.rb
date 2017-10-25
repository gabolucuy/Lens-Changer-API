class PosibleSolutionController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :getChildConcern, :index]

      def index
        @posible_solutions = PosibleSolution.where("user_id = ?, unsolved_problem_id = ?" ,params[:user_id, :unsolved_problem_id])
        json_response(@posible_solutions)
      end

      def create
        data =  JSON.parse(params[:data])
        response = ""
        data.each do |json_up|
            response = create_posible_solution(json_up)
        end
        json_response(response)
      end

      def create_posible_solution(json_up)
          posible_solution = PosibleSolution.new( :id => json_up["id"],
                                            :user_id => json_up["user_id"],
                                            :child_id => json_up["child_id"],
                                            :unsolvedProblem_id => json_up["unsolvedProblem_id"],
                                            :childConcern_id => json_up["childConcern_id"],
                                            :adultConcern_id => json_up["adultConcern_id"],
                                            :posibleSolution => json_up["posibleSolution"])
              api_child = Child.where("child_id = ? AND user_id = ?",params[:child_id], params[:user_id] ).first
              api_posible_solution = PosibleSolution.where("id = ? AND user_id = ? AND child_id= ? AND unsolvedProblem_id = ?" ,json_up["id"], json_up["user_id"], json_up["child_id"], json_up["unsolvedProblem_id"])
              if api_posible_solution.exists?
                   if api_posible_solution.update(:id => json_up["id"],
                                                     :user_id => json_up["user_id"],
                                                     :child_id => json_up["child_id"],
                                                     :unsolvedProblem_id => json_up["unsolvedProblem_id"],
                                                     :childConcern_id => json_up["childConcern_id"],
                                                     :adultConcern_id => json_up["adultConcern_id"],
                                                     :posibleSolution => json_up["posibleSolution"])
                       response = { message: "Posible Solution updated successfully"}
                   else
                       response = { message: "Error, Posible Solution was not updated successfully"}
                   end
              else
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
