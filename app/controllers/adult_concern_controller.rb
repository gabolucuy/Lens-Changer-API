class AdultConcernController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getAdultConcern, :index]

        def index
          @adult_concerns = AdultConcern.where("unsolved_problem_id = ?" ,params[:unsolved_problem_id])
          json_response(@adult_concerns)
        end

        def create
          data =  JSON.parse(params[:data])
          response = ""
          data.each do |json_up|
              response = create_adult_concern(json_up,params[:unsolved_problem_id])
          end
          json_response(response)
        end

        def create_adult_concern(json_up)
            adult_concern = AdultConcern.new(:description => json_up["description"],
                                              :unsolved_problem_id => json_up["unsolved_problem_id"])
                # api_child = Child.where("child_id = ? AND user_id = ?",json_up["child_id"], user_id ).first
                # api_unsolved_problem = UnsolvedProblem.where("child_id = ? AND user_id = ? AND unsolved_problem_id_app = ?" ,api_child.id, user_id, json_up["id"])
                # if api_unsolved_problem.exists?
                #     if api_unsolved_problem.update(:description => json_up["description"],
                #                         :solved => json_up["solved"],
                #                         :unsolved_problem_id_app => json_up["id"],
                #                         :unsolved_order => json_up["unsolved_order"],
                #                         :unsolved_score => json_up["unsolved_score"])
                #         response = { message: "Unsolved Problem updated"}
                #     else
                #         response = { message: "Error, no Unsolved Problem created"}
                #     end
                # else
                #     unsolved_problem.child_id = api_child.id
                    if adult_concern.save
                        response = { message: "Adult Concern created"}
                    else
                        response = { message: "Error, no Adult Concern created"}
                    end
                end

            return response
        end

        def getAdultConcern
            @adult_concern = AdultConcern.where(id: params[:adult_concern_id])
            json_response(@adult_concern)
        end

        def protect_against_forgery?
            false
        end

        private

        def adult_concern_params
            params.permit(
                :description,
                :unsolved_problem_id,
                )
        end
end
