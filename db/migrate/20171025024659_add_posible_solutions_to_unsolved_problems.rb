class AddPosibleSolutionsToUnsolvedProblems < ActiveRecord::Migration[5.1]
  def change
    add_reference :posible_solutions, :unsolved_problem, foreign_key: true
  end
end
