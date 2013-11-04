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

ActiveRecord::Schema.define(version: 20131104163441) do

  create_table "activities", force: true do |t|
    t.integer  "room_id"
    t.integer  "user_id"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "activities", ["room_id", "user_id"], name: "index_activities_on_room_id_and_user_id", unique: true, using: :btree
  add_index "activities", ["room_id"], name: "index_activities_on_room_id", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "attach_files", force: true do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["room_id", "created_at"], name: "index_messages_on_room_id_and_created_at", using: :btree
  add_index "messages", ["user_id", "created_at"], name: "index_messages_on_user_id_and_created_at", using: :btree

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "no_pass",         default: false
    t.string   "salt"
    t.string   "remember_token"
    t.text     "users"
    t.integer  "user_id"
  end

  add_index "rooms", ["name"], name: "index_rooms_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "string"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
