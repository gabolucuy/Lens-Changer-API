class AlsupShareController < ApplicationController
    skip_before_action :authorize_request, only: [:create,:index,:showShered,:sharedChilds,:getChild,:getLaggingSkills,:getSharedUnsolvedProblems,:getSharedChildConcerns,:getSharedAdultConcerns,:getSharedPosibleSolutions,:getSharedSolutionCommentaries]

    def create
        response = { message: "ALSUP"}

        child_id_api = User.find(params[:user_id]).children.find_by_child_id(params[:child_id])
        if(child_id_api==nil)
            response = { message: "Child already uploaded to the cloud, try again"}
        else

            alsupshare = AlsupShare.new(child_id: child_id_api.id, user_id: params[:friend_id])   	
            if alsupshare.save
        		response = { message: "ALSUP successfully shared"}
        	else
        		response = { message: "ALSUP already shared"}
        	end
        end   
        json_response(response)
    end

    def index
        @childs_id = AlsupShare.select("child_id").where("user_id = ?",params[:user_id])
        @childs = []
        @childs_id.each do |id|
            @childs = @childs + Child.select("*").where("id = ?",id['child_id'])
        end
        render json: @childs
    end

    def getChild
        @child = Child.where(id: params[:child_id]).first
        render json: @child
    end

    def getSharedUnsolvedProblems
        @unsolvedProblems = UnsolvedProblem.where(child_id: params[:child_id])
        render json: @unsolvedProblems
    end

    def getSharedChildConcerns
        @childConcerns = ChildConcern.where(user_id: params[:user_id],child_id: params[:child_id],unsolved_problem_id: params[:unsolved_problem_id])
        render json: @childConcerns
    end

    def getSharedAdultConcerns
        @adultConcerns = AdultConcern.where(user_id: params[:user_id],child_id: params[:child_id],unsolved_problem_id: params[:unsolved_problem_id])
        render json: @adultConcerns
    end

    def getSharedPosibleSolutions
        @posibleSolutions = PosibleSolution.where(unsolved_problem_id: params[:unsolved_problem_id])
        render json: @posibleSolutions
    end

    def getSharedSolutionCommentaries
        @solutionsComentaries = SolutionCommentary.where(posible_solution_id: params[:posible_solution_id])
        render json: @solutionsComentaries
    end


    def showShered
        # AlsupShare.where(child_id: child_id_api).includes(:user)
        
        child_id_api = User.find(params[:user_id]).children.find_by_child_id(params[:child_id])
        if(child_id_api==nil)
            render json: false
        else
            api_alsup = AlsupShare.find_by_child_id(child_id_api.id)
            if api_alsup == nil
                render json: false
            else
                render json: api_alsup.user
            end
        end
    end
	
	def protect_against_forgery?
            false
    end

    private

    def alsup_share_params
      params.permit(
      :user_id,
      :child_id
      )
    end
end
