class ChangePosibleSolutionTable < ActiveRecord::Migration[5.1]
  def change
  	remove_column :posible_solutions, :user_id, :integer
  	remove_column :posible_solutions, :child_id, :integer
  	remove_column :posible_solutions, :unsolvedProblem_id, :integer
  	remove_column :posible_solutions, :childConcern_id, :integer
  	remove_column :posible_solutions, :adultConcern_id, :integer
  	remove_column :posible_solutions, :posibleSolution, :text
  	add_column :posible_solutions, :rating, :integer
  	add_column :posible_solutions, :posible_solution_id, :integer
  	add_column :posible_solutions, :description, :text
  end
end
