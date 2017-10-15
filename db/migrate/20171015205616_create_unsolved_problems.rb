class CreateUnsolvedProblems < ActiveRecord::Migration[5.1]
  def change
    create_table :unsolved_problems do |t|
      t.text :description
      t.boolean :solved
      t.integer :unsolved_order
      t.integer :unsolved_score

      t.timestamps
    end
  end
end
