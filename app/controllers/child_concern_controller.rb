class ChildConcernController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :getChildConcern]

      def create
          if(ChildConcern.exists?(params[:id]))
              ChildConcern.update(:id => params[:id], :description => params[:description], :order => params[:order], :unsolved_problem_id => params[:unsolved_problem_id])
              response = { message: "Preocupacion actualizada!"}
              json_response(response)
          else
            child_concern = ChildConcern.create(:id => params[:id], :description => params[:description], :order => params[:order], :unsolved_problem_id => params[:unsolved_problem_id])
            response = { message: "Preocupacion agregada!"}
            json_response(response)
          end
      end


      def getChildConcern
          @child_concern = ChildConcern.where(id: params[:child_concern_id])
          json_response(@child_concern)
      end

      def protect_against_forgery?
          false
        end

      private

      def child_concern_params
          params.permit(
              :description,
              :order,
              :unsolved_problem_id,
              )
      end

end
