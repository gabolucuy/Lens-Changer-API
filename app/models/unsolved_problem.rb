class UnsolvedProblem < ApplicationRecord
	belongs_to :user
	validates_presence_of  :description,:solved ,:unsolved_order ,:unsolved_score ,:user
end
