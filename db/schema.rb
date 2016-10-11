# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161007140544) do

  create_table "games", force: :cascade do |t|
    t.string   "name",         null: false
    t.integer  "year",         null: false
    t.string   "manufacturer"
    t.string   "notes"
    t.boolean  "is_active",    null: false
    t.integer  "photo_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "games", ["is_active"], name: "index_games_on_is_active"
  add_index "games", ["photo_id"], name: "index_games_on_photo_id"
  add_index "games", ["year"], name: "index_games_on_year"

  create_table "likes", force: :cascade do |t|
    t.string   "fan_ip",     null: false
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["fan_ip"], name: "index_likes_on_fan_ip"
  add_index "likes", ["game_id"], name: "index_likes_on_game_id"

  create_table "photos", force: :cascade do |t|
    t.string   "url",        null: false
    t.string   "thumb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
