class AddColumnChildIdToChildConcerns < ActiveRecord::Migration[5.1]
  def change
    add_column :child_concerns, :child_id, :integer
  end
end
