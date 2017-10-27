class AddColumnToChildConcern < ActiveRecord::Migration[5.1]
  def change
    add_column :child_concerns, :concern_id, :integer
  end
end
