# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_24_211903) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_days_on_plan_id"
  end

  create_table "days_progressions", force: :cascade do |t|
    t.bigint "day_id"
    t.bigint "progression_id"
    t.index ["day_id"], name: "index_days_progressions_on_day_id"
    t.index ["progression_id"], name: "index_days_progressions_on_progression_id"
  end

  create_table "movements", force: :cascade do |t|
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_movements_on_slug", unique: true
  end

  create_table "plans", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_plans_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "progressions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "min_sets", limit: 2, default: 1, null: false
    t.integer "max_sets", limit: 2, default: 1, null: false
    t.integer "min_reps", limit: 2, default: 1, null: false
    t.integer "max_reps", limit: 2, default: 1, null: false
    t.decimal "weight_increments", precision: 8, scale: 3, default: "2.5", null: false
    t.integer "rep_increments", limit: 2, default: 1, null: false
    t.integer "set_increments", limit: 2, default: 1, null: false
    t.bigint "profile_id", null: false
    t.bigint "movement_id", null: false
    t.decimal "initial_weight", precision: 8, scale: 3, default: "1.0", null: false
    t.integer "initial_reps", limit: 2, default: 1, null: false
    t.integer "initial_sets", limit: 2, default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movement_id"], name: "index_progressions_on_movement_id"
    t.index ["profile_id"], name: "index_progressions_on_profile_id"
  end

  create_table "refresh_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "jti"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_refresh_tokens_on_jti", unique: true
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "days", "plans"
  add_foreign_key "plans", "profiles"
  add_foreign_key "profiles", "users"
  add_foreign_key "progressions", "movements"
  add_foreign_key "progressions", "profiles"
  add_foreign_key "refresh_tokens", "users"
end
