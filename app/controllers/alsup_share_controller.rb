class AlsupShareController < ApplicationController
    skip_before_action :authorize_request, only: [:create,:index,:showShered]

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
      @sharedAlsups = AlsupShare.where("user_id = ?",params[:user_id])
      render json: @sharedAlsups
    end

    def sharedChilds
        childs = User.find(params[:user_id]).children.find_by_child_id(params[:child_id])
        render json: childs
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
