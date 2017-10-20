class AddChildToUnsolvedProblem < ActiveRecord::Migration[5.1]
  def change
    add_reference :unsolved_problems, :child, foreign_key: true
  end
end
