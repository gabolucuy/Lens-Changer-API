class AddColumnLagskillIdToLaggingSkills < ActiveRecord::Migration[5.1]
  def change
    add_column :lagging_skills, :lagskill_id, :integer
  end
end
