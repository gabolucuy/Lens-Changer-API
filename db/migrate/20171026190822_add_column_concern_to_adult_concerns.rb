class AddColumnConcernToAdultConcerns < ActiveRecord::Migration[5.1]
  def change
    add_column :adult_concerns, :concern_id, :integer
  end
end
