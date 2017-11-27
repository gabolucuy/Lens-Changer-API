class SolutionPair < ApplicationRecord
  belongs_to :user
  belongs_to :child
  belongs_to :posible_solution
end
