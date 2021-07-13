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

ActiveRecord::Schema.define(version: 2021_07_13_120041) do

  create_table "deliveries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "number", null: false
    t.bigint "bowler_id", null: false
    t.bigint "batsman_id", null: false
    t.bigint "helped_by_id"
    t.string "action", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "inning_id"
    t.string "extra"
    t.index ["batsman_id"], name: "index_deliveries_on_batsman_id"
    t.index ["bowler_id"], name: "index_deliveries_on_bowler_id"
    t.index ["helped_by_id"], name: "index_deliveries_on_helped_by_id"
    t.index ["inning_id"], name: "index_deliveries_on_inning_id"
  end

  create_table "innings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.integer "score", default: 0
    t.integer "wickets", default: 0
    t.bigint "strike_batsman_id"
    t.bigint "non_strike_batsman_id"
    t.bigint "bowler_id"
    t.boolean "in_progress", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status", default: "NOT STARTED"
    t.index ["bowler_id"], name: "index_innings_on_bowler_id"
    t.index ["non_strike_batsman_id"], name: "index_innings_on_non_strike_batsman_id"
    t.index ["strike_batsman_id"], name: "index_innings_on_strike_batsman_id"
    t.index ["team_id"], name: "index_innings_on_team_id"
  end

  create_table "matches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "home_team_id", null: false
    t.bigint "away_team_id", null: false
    t.string "toss"
    t.string "toss_decision"
    t.integer "overs", default: 6
    t.boolean "single_batsman_allowed", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "first_innings_id"
    t.bigint "second_innings_id"
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["first_innings_id"], name: "index_matches_on_first_innings_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["second_innings_id"], name: "index_matches_on_second_innings_id"
  end

  create_table "stats", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "runs_scored", default: 0
    t.integer "balls_faced", default: 0
    t.integer "runs_given", default: 0
    t.integer "balls_bowled", default: 0
    t.integer "wickets_taken", default: 0
    t.integer "fours", default: 0
    t.integer "sixes", default: 0
    t.integer "catches", default: 0
    t.integer "run_outs", default: 0
    t.integer "batting_order", default: 100
    t.integer "bowling_order", default: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "match_id", null: false
    t.index ["match_id"], name: "index_stats_on_match_id"
    t.index ["user_id"], name: "index_stats_on_user_id"
  end

  create_table "teams", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams_tournaments", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "tournament_id"
    t.integer "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tournament_id", "team_id"], name: "index_teams_tournaments_on_tournament_id_and_team_id"
  end

  create_table "teams_users", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id", "user_id"], name: "index_teams_users_on_team_id_and_user_id"
  end

  create_table "tournaments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  add_foreign_key "deliveries", "innings"
  add_foreign_key "deliveries", "users", column: "batsman_id"
  add_foreign_key "deliveries", "users", column: "bowler_id"
  add_foreign_key "deliveries", "users", column: "helped_by_id"
  add_foreign_key "innings", "teams"
  add_foreign_key "innings", "users", column: "bowler_id"
  add_foreign_key "innings", "users", column: "non_strike_batsman_id"
  add_foreign_key "innings", "users", column: "strike_batsman_id"
  add_foreign_key "matches", "innings", column: "first_innings_id"
  add_foreign_key "matches", "innings", column: "second_innings_id"
  add_foreign_key "matches", "users", column: "away_team_id"
  add_foreign_key "matches", "users", column: "home_team_id"
  add_foreign_key "stats", "matches"
  add_foreign_key "stats", "users"
end
