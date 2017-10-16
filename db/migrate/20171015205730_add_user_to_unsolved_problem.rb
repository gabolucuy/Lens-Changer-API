class AddUserToUnsolvedProblem < ActiveRecord::Migration[5.1]
  def change
    add_reference :unsolved_problems, :user, foreign_key: true
  end
end
