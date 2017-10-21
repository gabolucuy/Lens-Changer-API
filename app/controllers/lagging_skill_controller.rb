class LaggingSkillController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getLaggingSkill]

    # def create
    #     LaggingSkill.destroy_all
    #     if(LaggingSkill.exists?(params[:id]))
    #         LaggingSkill.update(:id => params[:id], :description => params[:description], :checked => params[:checked], :child_id => params[:child_id])
    #         laggingSkill = LaggingSkill.where(id: params[:lagging_skill_id])
    #         #laggingSkillUncheck(laggingSkill)
    #
    #         response = { message: "Dificultad actualizada!"}
    #         json_response(response)
    #     else
    #       laggingSkill = LaggingSkill.create(:id => params[:id], :description => params[:description], :checked => params[:checked], :child_id => params[:child_id])
    #       response = { message: "Dificultad agregada!"}
    #       json_response(response)
    #     end
    # end

    def create
      laggingSkillData = params[:data]

      laggingSkillData.each do |laggingSkill|
        laggingSkill = LaggingSkill.create(:id => params[:id], :description => params[:description], :checked => params[:checked], :child_id => params[:child_id])
      end
      response = { message: "LaggingSkills agregada!"}
      json_response(response)
    end


    def getLaggingSkill
        @lagging_skill = LaggingSkill.where(id: params[:lagging_skill_id])
        json_response(@lagging_skill)
    end

    def destroy
        @lagging_skill = LaggingSkill.where(id: params[:lagging_skill_id])
        @lagging_skill.destroy
        response = { message: "LaggingSkill Unchecked!"}
        json_response(response)
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
