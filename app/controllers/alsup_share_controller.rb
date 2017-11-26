class AlsupShareController < ApplicationController
    skip_before_action :authorize_request, only: [:create,:index,:showShered,:sharedChilds,:getChild,:getLaggingSkills,:getSharedUnsolvedProblems,:getSharedChildConcerns,:getSharedAdultConcerns,:getSharedPosibleSolutions,:getSharedSolutionCommentaries,:destroy,:notifications]

    def create
        response = { message: "ALSUP"}

        child_id_api = User.find(params[:user_id]).children.find_by_child_id(params[:child_id])
        if(child_id_api==nil)
            response = { message: "Child already uploaded to the cloud, try again"}
        else

            alsupshare = AlsupShare.new(child_id: child_id_api.id, user_id: params[:friend_id])
            if alsupshare.save
            @user_s= User.find(params[:user_id])
            @childShared = Children.find(child_id_api.id)
            title = @user_s.name + " " + @user_s.last_name
            text = "The shared child is " + @childShared.name + " and the " +@user_s.name +" email is " + @user_s.email
            notifications(params[:friend_id],text,title)
        		response = { message: "ALSUP successfully shared"}
        	else
        		response = { message: "ALSUP already shared"}
        	end
        end
        json_response(response)
    end

    def notifications(value, text, title)
      require 'net/http'
      require 'uri'
      params = {"app_id" => "46f73879-5b3e-45a0-90de-91f455b65eb4",
                "heading": title,
                "contents" => {"en" => text},
                "filters" => [{"field": "tag", "key": "User_Id", "relation": "=", "value": value}]
                #"filters" => [{"field": "tag", "key": "User_Id", "relation": "=", "value": @friend_id}]
      }
      uri = URI.parse('https://onesignal.com/api/v1/notifications')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.path,
                                    'Content-Type'  => 'application/json;charset=utf-8',
                                    'Authorization' => "Basic YzQ4ZGQ1MjktNmY1Ni00YTc5LTk0NDAtNDJiMzUxZjUyNTEz")
      request.body = params.as_json.to_json
      response = http.request(request)
      puts response.body
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

    def destroy
        child_shared = User.find(params[:user_id]).children.find_by_child_id(params[:child_id])
        alsupShare = AlsupShare.find_by_child_id(child_shared.id)
        alsupShare.destroy
        response = { message: "Now you stopped sharing this ALSUP",status: "Succes"}
        json_response(response)
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
