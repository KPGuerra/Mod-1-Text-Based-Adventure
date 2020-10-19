# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_19_174421) do

  create_table "battles", force: :cascade do |t|
    t.integer "enemy_id"
    t.integer "character_id"
    t.string "result"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "class"
    t.string "description"
    t.integer "hp"
    t.integer "level"
    t.integer "experience_points"
    t.integer "user_id"
  end

  create_table "enemies", force: :cascade do |t|
    t.string "name"
    t.string "class"
    t.string "description"
    t.integer "hp"
    t.integer "level"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "type"
    t.integer "character_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "user_name"
    t.string "password"
    t.integer "room_count"
  end

end
