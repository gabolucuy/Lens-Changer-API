class LaggingSkillController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getLaggingSkill]

    def create
        lagging_skill = LaggingSkill.create(lagging_skill_params)
        response = { message: "Dificultad agregada!" }
        json_response(response)
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
