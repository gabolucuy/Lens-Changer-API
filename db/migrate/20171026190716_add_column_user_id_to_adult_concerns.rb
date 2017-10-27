class AddColumnUserIdToAdultConcerns < ActiveRecord::Migration[5.1]
  def change
    add_column :adult_concerns, :user_id, :integer
  end
end
