# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171126153440) do

  create_table "adult_concerns", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unsolved_problem_id"
    t.integer "user_id"
    t.integer "child_id"
    t.integer "concern_id"
    t.index ["unsolved_problem_id"], name: "index_adult_concerns_on_unsolved_problem_id"
  end

  create_table "alsup_shares", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "child_id"
    t.integer "user_id"
    t.index ["child_id"], name: "index_alsup_shares_on_child_id"
    t.index ["user_id"], name: "index_alsup_shares_on_user_id"
  end

  create_table "child_concerns", force: :cascade do |t|
    t.text "description"
    t.integer "order"
    t.integer "unsolved_problem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "concern_id"
    t.integer "user_id"
    t.integer "child_id"
    t.index ["unsolved_problem_id"], name: "index_child_concerns_on_unsolved_problem_id"
  end

  create_table "children", force: :cascade do |t|
    t.integer "child_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_children_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_contacts_on_friend_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "friends_requests", force: :cascade do |t|
    t.integer "user_id"
    t.integer "applicant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_friends_requests_on_applicant_id"
    t.index ["user_id"], name: "index_friends_requests_on_user_id"
  end

  create_table "lagging_skills", force: :cascade do |t|
    t.text "description"
    t.integer "checked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "child_id"
    t.integer "lagskill_id"
    t.integer "user_id"
    t.index ["child_id"], name: "index_lagging_skills_on_child_id"
  end

  create_table "posible_solutions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rating"
    t.integer "posible_solution_id"
    t.text "description"
    t.integer "unsolved_problem_id"
    t.text "adult_concern_description"
    t.text "child_concern_description"
    t.index ["unsolved_problem_id"], name: "index_posible_solutions_on_unsolved_problem_id"
  end

  create_table "solution_commentaries", force: :cascade do |t|
    t.text "description"
    t.date "commented_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "posible_solution_id"
    t.integer "solution_commentary_id_app"
    t.index ["posible_solution_id"], name: "index_solution_commentaries_on_posible_solution_id"
  end

  create_table "solution_pairs", force: :cascade do |t|
    t.text "description"
    t.text "description2"
    t.integer "solution_id"
    t.integer "user_id"
    t.integer "child_id"
    t.integer "posible_solution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_solution_pairs_on_child_id"
    t.index ["posible_solution_id"], name: "index_solution_pairs_on_posible_solution_id"
    t.index ["user_id"], name: "index_solution_pairs_on_user_id"
  end

  create_table "unsolved_problems", force: :cascade do |t|
    t.text "description"
    t.integer "unsolved_order"
    t.integer "unsolved_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "child_id"
    t.integer "solved"
    t.integer "unsolved_problem_id_app"
    t.index ["child_id"], name: "index_unsolved_problems_on_child_id"
    t.index ["user_id"], name: "index_unsolved_problems_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
