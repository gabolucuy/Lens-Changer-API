class AddAdultConcernsToUnsolvedProblems < ActiveRecord::Migration[5.1]
  def change
    add_reference :adult_concerns, :unsolved_problem, foreign_key: true
  end
end
