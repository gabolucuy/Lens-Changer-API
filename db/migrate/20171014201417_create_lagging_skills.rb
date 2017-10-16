class CreateLaggingSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :lagging_skills do |t|
      t.text :description
      t.integer :checked
      t.integer :child_id

      t.timestamps
    end
  end
end
