class SolutionCommentaryController < ApplicationController
	def index
		
	end

	def create
        data =  JSON.parse(params[:data])
        response = ""
=begin  
        data.each do |json_up|
            response = create_unsolved_problem(json_up,params[:user_id])
        end
=end         
        json_response(response)		
	end

end
