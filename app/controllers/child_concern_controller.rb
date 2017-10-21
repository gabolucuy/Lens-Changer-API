class ChildConcernController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :getAdultConcern]

      def create
          child_concern= ChildConcern.create(adult_concern_params)
          response = { message: "Child concern agregado!" }
          json_response(response)
      end


      def getAdultConcern
          @child_concern = ChildConcern.where(id: params[:adult_concern_id])
          json_response(@child_concern)
      end

      private

      def adult_concern_params
          params.permit(
              :description,
              :order,
              :unsolved_problem_id,
              )
      end

end
