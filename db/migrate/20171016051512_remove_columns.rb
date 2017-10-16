class RemoveColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :adult_concerns, :unsolved_problem_id
  end
end
