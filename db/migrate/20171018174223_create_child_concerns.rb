class CreateChildConcerns < ActiveRecord::Migration[5.1]
  def change
    create_table :child_concerns do |t|
      t.text :description
      t.integer :order
      t.references :unsolved_problem, foreign_key: true

      t.timestamps
    end
  end
end
