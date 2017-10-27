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
              response = create_adult_concern(json_up)
          end
          json_response(response)
        end

        def create_adult_concern(json_up)
            adult_concern = AdultConcern.new( :concern_id => json_up["id"],
                                              :description => json_up["description"],
                                              :unsolved_problem_id => json_up["unsolved_problem_id"],
                                              :child_id => params[:child_id],
                                              :user_id =>  params[:user_id])
                api_child = Child.where("child_id = ? AND user_id = ?",params[:child_id], params[:user_id] ).first
                puts "**************************"
                puts api_child.id
                api_adult_concern = AdultConcern.where("concern_id = ? AND unsolved_problem_id = ? AND child_id =? AND user_id = ?" ,json_up["id"], json_up["unsolved_problem_id"],params[:child_id], params[:user_id])
                if api_adult_concern.exists?
                     if api_adult_concern.update(:concern_id => json_up["id"],
                                                 :description => json_up["description"],
                                                 :unsolved_problem_id => json_up["unsolved_problem_id"])
                         response = { message: "Adult Concern updated"}
                     else
                         response = { message: "Error, Adult Concern created"}
                     end
                else
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
                :unsolved_problem_id
                )
        end
end
