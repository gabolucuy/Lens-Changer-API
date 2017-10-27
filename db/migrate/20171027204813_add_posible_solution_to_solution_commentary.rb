class AddPosibleSolutionToSolutionCommentary < ActiveRecord::Migration[5.1]
  def change
  	add_reference :solution_commentaries, :posible_solution, foreign_key: true
  end
end
