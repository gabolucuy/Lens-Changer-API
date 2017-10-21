class LaggingSkillController < ApplicationController
    skip_before_action :authorize_request, only: [:create, :getLaggingSkill]

    def create
      destroyLaggingSkillsOfChild(params[:child_id])
      data =  JSON.parse(params[:data])
      response = ""
      data.each do |json_up|
          puts "************************"
          puts data
          response = create_laggingSkill(json_up)
      end
      json_response(response)
    end

    def create_laggingSkill(json_up)
        laggingSkillsData = LaggingSkill.new( :id => json_up["id"],
                                         :description => json_up["description"],
                                         :checked => json_up["checked"],
                                         :child_id => json_up["child_id"])
        laggingSkillsData.save

            response = { message: "laggingSkill created"}
        return response
    end

    def destroyLaggingSkillsOfChild(child_id)
        laggingSkillsDB = LaggingSkill.where(child_id: child_id)
        laggingSkillsDB.each do |laggingSkill|
          laggingSkill.destroy
        end
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
