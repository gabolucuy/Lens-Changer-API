class AddColumnToChildConcerns < ActiveRecord::Migration[5.1]
  def change
    add_column :child_concerns, :user_id, :integer
  end
end
