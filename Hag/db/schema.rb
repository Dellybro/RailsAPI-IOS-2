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

ActiveRecord::Schema.define(version: 20150626044909) do

  create_table "clients", force: :cascade do |t|
    t.integer  "unique_id",       limit: 4
    t.string   "last_name",       limit: 255
    t.string   "first_name",      limit: 255
    t.string   "password",        limit: 255
    t.string   "password_digest", limit: 255
    t.string   "bio",             limit: 255
    t.string   "auth_token",      limit: 255
    t.string   "city",            limit: 255
    t.string   "state",           limit: 255
    t.integer  "zipcode",         limit: 4
    t.string   "address",         limit: 255
    t.string   "propic",          limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "email",           limit: 255
  end

  add_index "clients", ["email"], name: "index_clients_on_email", unique: true, using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "provider_id",  limit: 255
    t.string   "client_id",    limit: 255
    t.string   "messageTitle", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "message_id",     limit: 4
    t.integer  "user_unique_id", limit: 4
    t.string   "message",        limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string   "last_name",       limit: 255
    t.string   "first_name",      limit: 255
    t.string   "password",        limit: 255
    t.string   "password_digest", limit: 255
    t.string   "bio",             limit: 255
    t.string   "auth_token",      limit: 255
    t.string   "city",            limit: 255
    t.string   "state",           limit: 255
    t.integer  "zipcode",         limit: 4
    t.string   "address",         limit: 255
    t.string   "propic",          limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "unique_id",       limit: 4
    t.string   "email",           limit: 255
  end

  add_index "providers", ["email"], name: "index_providers_on_email", unique: true, using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "client_id",   limit: 4
    t.integer  "provider_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "client_id",       limit: 4
    t.integer  "provider_id",     limit: 4
    t.string   "request_message", limit: 255
    t.boolean  "seen",            limit: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "type",        limit: 255
    t.integer  "provider_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "unique_ids", force: :cascade do |t|
    t.string   "user_id",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
