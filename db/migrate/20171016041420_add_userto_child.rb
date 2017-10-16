class AddUsertoChild < ActiveRecord::Migration[5.1]
  def change
    add_reference :children, :user, foreing_key: true
  end
end
