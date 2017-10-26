class ChildConcernController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :getChildConcern, :index]

      def index
        @child_concerns = ChildConcern.where("unsolved_problem_id = ?" ,params[:unsolved_problem_id])
        json_response(@child_concerns)
      end

      def create
        data =  JSON.parse(params[:data])
        response = ""
        data.each do |json_up|
            response = create_child_concern(json_up)
        end
        json_response(response)
      end

      def create_child_concern(json_up)
          child_concern = ChildConcern.new( :concern_id => json_up["id"],
                                            :description => json_up["description"],
                                            :order => json_up["unsolved_order"],
                                            :unsolved_problem_id => json_up["unsolved_problem_id"])
              api_child = Child.where("child_id = ? AND user_id = ?",params[:child_id], params[:user_id] ).first
              api_child_concern = ChildConcern.where("id = ? AND unsolved_problem_id = ?" ,json_up["id"], json_up["unsolved_problem_id"])
              if api_child_concern.exists?
                   if api_child_concern.update(:concern_id => json_up["id"],
                                               :description => json_up["description"],
                                               :order => json_up["unsolved_order"],
                                               :unsolved_problem_id => json_up["unsolved_problem_id"])
                       response = { message: "Child Concern updated"}
                   else
                       response = { message: "Error, Child Concern created"}
                   end
              else
                  if child_concern.save
                      response = { message: "Child Concern created"}
                  else
                      response = { message: "Error, no Child Concern created"}
                  end
              end


          return response
      end

      def getChildConcern
          @child_concern = ChildConcern.where(concern_id: params[:child_concern_id])
          json_response(@child_concern)
      end

      def protect_against_forgery?
          false
      end
end
