class AddColumnChildIdToAdultConcerns < ActiveRecord::Migration[5.1]
  def change
    add_column :adult_concerns, :child_id, :integer
  end
end
