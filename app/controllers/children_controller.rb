class ChildrenController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getChild,:show,:getLaggingSkillsOfChild]

        def create
            c = Child.where(child_id: params[:child_id], user_id: params[:user_id])
            if(c.exists?)
                c.update(:name => params[:name], :gender => params[:gender], :birthday => params[:birthday])
                response = { message: "Child Updated"}
                json_response(response)
            else
              child = Child.create(child_params)
              response = { message: "Child created"}
              json_response(response)
            end
        end

        def getChild
            @child = Child.where(child_id: params[:child_id], user_id: params[:user_id])
            json_response(@child)
        end

        def getLaggingSkillsOfChild
            @child = Child.where(id: params[:child_id])
            @laggingSkill = LaggingSkill.where(child_id: params[:child_id])
            json_response(@laggingSkill)
        end

        def show
            @child = Child.find_by(child_id: params[:id], user_id: params[:user_id])
            json_response(@child)
        end

        def protect_against_forgery?
            false
          end

        private

        def child_params
            params.permit(
                :id,
                :child_id,
                :name,
                :gender,
                :birthday,
                :user_id
                )
        end
end
