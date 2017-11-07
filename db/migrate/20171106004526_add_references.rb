class AddReferences < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :contacts, :users, column: :friend_id
    add_foreign_key :friends_requests, :users, column: :applicant_id
  end
end
