class CreateChildren < ActiveRecord::Migration[5.1]
  def change
    #drop_table :children
    create_table :children do |t|
      t.string "name"
      t.string "gender"
      t.date "birthday"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false

      t.timestamps
    end
  end
end
