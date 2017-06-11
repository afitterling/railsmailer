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

ActiveRecord::Schema.define(version: 20170611104803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "access_tokens", ["user_id"], name: "index_access_tokens_on_user_id", using: :btree

  create_table "device_access_tokens", force: :cascade do |t|
    t.string   "token"
    t.integer  "sequence"
    t.integer  "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "device_access_tokens", ["device_id"], name: "index_device_access_tokens_on_device_id", using: :btree
  add_index "device_access_tokens", ["token"], name: "index_device_access_tokens_on_token", unique: true, using: :btree

  create_table "devices", force: :cascade do |t|
    t.integer  "last_used_key_sequence", default: -1, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id"
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "log_data", force: :cascade do |t|
    t.integer  "device_id"
    t.json     "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "log_data", ["device_id"], name: "index_log_data_on_device_id", using: :btree

  create_table "mailers", force: :cascade do |t|
    t.string   "address",               default: "localhost", null: false
    t.integer  "port",                  default: 25,          null: false
    t.string   "domain"
    t.string   "user_name"
    t.string   "encrypted_password"
    t.string   "encrypted_password_iv"
    t.integer  "authentication"
    t.boolean  "enable_starttls_auto",  default: true,        null: false
    t.string   "openssl_verify_mode"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "access_tokens", "users"
  add_foreign_key "device_access_tokens", "devices"
  add_foreign_key "devices", "users"
  add_foreign_key "log_data", "devices"
end
