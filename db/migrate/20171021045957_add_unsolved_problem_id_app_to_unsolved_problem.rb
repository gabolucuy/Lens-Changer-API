class AddUnsolvedProblemIdAppToUnsolvedProblem < ActiveRecord::Migration[5.1]
  def change
    add_column :unsolved_problems, :unsolved_problem_id_app, :integer
  end
end
