class CreateAdultConcerns < ActiveRecord::Migration[5.1]
  def change
    create_table :adult_concerns do |t|
      t.text :description
      #t.integer :unsolved_problem_id

      t.timestamps
    end
  end
end
