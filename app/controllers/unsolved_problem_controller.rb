class UnsolvedProblemController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getUnsolvedProblem]

    	def create
            data =  JSON.parse(params[:data])
            response = ""
            data.each do |json_up|
                puts "************************"
                puts data
                response = create_unsolved_problem(json_up,params[:user_id])
            end
            json_response(response)
      	end
        def create_unsolved_problem(json_up,user_id)
            unsolved_problem = UnsolvedProblem.new(:description => json_up["description"],
                                                   :solved => json_up["solved"],
                                                   :unsolved_problem_id_app => json_up["id"],
                                                   :unsolved_order => json_up["unsolved_order"],
                                                   :unsolved_score => json_up["unsolved_score"],
                                                   :user_id => user_id,
                                                   :child_id => json_up["child_id"],
                                                    )

                api_unsolved_problem = UnsolvedProblem.where("child_id = ? AND user_id = ? AND unsolved_problem_id_app = ?" ,json_up["child_id"], user_id, json_up["id"])
                if api_unsolved_problem.exists?
                    if api_unsolved_problem.update(:description => json_up["description"],
                                        :solved => json_up["solved"],
                                        :unsolved_problem_id_app => json_up["id"],
                                        :unsolved_order => json_up["unsolved_order"],
                                        :unsolved_score => json_up["unsolved_score"])
                        response = { message: "Unsolved Problem created"}
                    else
                        response = { message: "Error, no Unsolved Problem created"}
                    end              
                else
                    api_child = Child.where("child_id = ? AND user_id = ?",json_up["child_id"], user_id ).first
                    unsolved_problem.child_id = api_child.id
                    if unsolved_problem.save
                        response = { message: "Unsolved Problem created"}
                    else
                        response = { message: "Error, no Unsolved Problem created"}
                    end
                end

            return response
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
            :child_id,
            :data
                )
        end
end
