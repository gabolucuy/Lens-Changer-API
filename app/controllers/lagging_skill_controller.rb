class LaggingSkillController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getLaggingSkill]

    def create
        if(LaggingSkill.exists?(params[:id]))
            LaggingSkill.update(:id => params[:id], :description => params[:description], :checked => params[:checked], :child_id => params[:child_id])
            response = { message: "Dificultad actualizada!"}
            json_response(response)
        else
          laggingSkill = LaggingSkill.create(:id => params[:id], :description => params[:description], :checked => params[:checked], :child_id => params[:child_id])
          response = { message: "Dificultad agregada!"}
          json_response(response)
        end
    end


    def getLaggingSkill
        @lagging_skill = LaggingSkill.where(id: params[:lagging_skill_id])
        json_response(@lagging_skill)
    end

    def protect_against_forgery?
        false
      end

    private

    def lagging_skill_params
        params.permit(
            :description,
            :checked,
            :child_id,
            )
    end

end
