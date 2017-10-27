class CreateSolutionCommentaries < ActiveRecord::Migration[5.1]
  def change
    create_table :solution_commentaries do |t|
      t.text :description
      t.date :commented_at

      t.timestamps
    end
  end
end
