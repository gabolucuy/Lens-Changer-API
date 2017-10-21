class ChangeSolvedFromUnsolvedProblem < ActiveRecord::Migration[5.1]
  def change
  	remove_column :unsolved_problems, :solved, :boolean
    add_column :unsolved_problems, :solved, :integer
  end
end
