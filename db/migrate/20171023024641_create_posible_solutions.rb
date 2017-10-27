class CreatePosibleSolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :posible_solutions do |t|
      t.integer :user_id
      t.integer :child_id
      t.integer :unsolvedProblem_id
      t.integer :childConcern_id
      t.integer :adultConcern_id
      t.text :posibleSolution

      t.timestamps
    end
  end
end
