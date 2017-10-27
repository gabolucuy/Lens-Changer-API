class AddColumnUserIdToLaggingSkills < ActiveRecord::Migration[5.1]
  def change
    add_column :lagging_skills, :user_id, :integer
  end
end
