class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      add_foreign_key :contacts, :users, column: :friend_id
      t.references :friend
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
