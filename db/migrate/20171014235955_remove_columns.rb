class RemoveColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :lagging_skills, :child_id
  end
end
