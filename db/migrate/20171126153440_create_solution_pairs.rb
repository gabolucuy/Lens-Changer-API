class CreateSolutionPairs < ActiveRecord::Migration[5.1]
  def change
    create_table :solution_pairs do |t|
      t.text :description
      t.text :description2
      t.integer :solution_id
      t.references :user, foreign_key: true
      t.references :child, foreign_key: true
      t.references :posible_solution, foreign_key: true

      t.timestamps
    end
  end
end
