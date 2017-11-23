class RemoveGenderAndBirthdayFromChild < ActiveRecord::Migration[5.1]
  def change
  	remove_column :children, :gender, :string
  	remove_column :children, :birthday, :date
  end
end
