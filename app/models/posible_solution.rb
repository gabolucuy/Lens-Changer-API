class PosibleSolution < ApplicationRecord
	belongs_to :unsolved_problem
	has_many :solution_commentaries
end
