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

ActiveRecord::Schema.define(version: 20150426184817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carbon_sources", force: :cascade do |t|
    t.string "name",              null: false
    t.float  "conversion_factor", null: false
    t.string "units",             null: false
    t.string "citation"
    t.string "citation_url"
  end

  add_index "carbon_sources", ["name"], name: "index_carbon_sources_on_name", unique: true, using: :btree

  create_table "usages", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.integer  "carbon_source_id", null: false
    t.float    "amount_used",      null: false
    t.date     "start_date",       null: false
    t.date     "end_date",         null: false
    t.text     "notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "use_reason_id",    null: false
  end

  create_table "use_reasons", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "member", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
