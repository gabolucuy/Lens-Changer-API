class CreateFriendsRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friends_requests do |t|
      t.references :user, foreign_key: true
      t.references :applicant
      t.timestamps
    end
  end

end
