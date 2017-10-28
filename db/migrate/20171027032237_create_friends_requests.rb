class CreateFriendsRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friends_requests do |t|
      add_foreign_key :friends_requests, :users, column: :applicant_id
      t.references :user, foreign_key: true
      t.references :applicant

      t.timestamps
    end
  end
end
