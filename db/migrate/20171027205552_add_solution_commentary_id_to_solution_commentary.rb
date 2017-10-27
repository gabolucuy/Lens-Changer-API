class AddSolutionCommentaryIdToSolutionCommentary < ActiveRecord::Migration[5.1]
  def change
    add_column :solution_commentaries, :solution_commentary_id_app, :integer
  end
end
