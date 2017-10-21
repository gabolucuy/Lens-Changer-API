class UnsolvedProblem < ApplicationRecord
	belongs_to :user
	validates_presence_of  :description,:solved ,:unsolved_order ,:unsolved_score ,:user
  has_many :child_concerns
	has_many :adult_concerns
end
