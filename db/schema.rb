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

ActiveRecord::Schema.define(version: 20130722184722) do

  create_table "messages", force: true do |t|
    t.text     "content",    limit: 255
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["room_id", "created_at"], name: "index_messages_on_room_id_and_created_at"
  add_index "messages", ["user_id", "created_at"], name: "index_messages_on_user_id_and_created_at"

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "no_pass",         default: false
    t.string   "salt"
    t.string   "remember_token"
  end

  add_index "rooms", ["name"], name: "index_rooms_on_name"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "string"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["name"], name: "index_users_on_name"
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
