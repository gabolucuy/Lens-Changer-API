class AddAdultChildConcernToPosibleSolutions < ActiveRecord::Migration[5.1]
  def change
  	add_column :posible_solutions, :adult_concern_description, :text
  	add_column :posible_solutions, :child_concern_description, :text
  end
end
