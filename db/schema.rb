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

ActiveRecord::Schema.define(version: 20170609094805) do

  create_table "addresses", force: :cascade do |t|
    t.string   "city",              limit: 255
    t.integer  "postcode",          limit: 4,   null: false
    t.string   "street",            limit: 255, null: false
    t.integer  "building_number",   limit: 4,   null: false
    t.string   "secondary_address", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "addresses", ["postcode", "street", "building_number"], name: "index_addresses_on_postcode_and_street_and_building_number", unique: true, using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "address_id", limit: 4
    t.integer  "chief_id",   limit: 4
  end

  add_index "departments", ["address_id"], name: "index_departments_on_address_id", using: :btree
  add_index "departments", ["chief_id"], name: "index_departments_on_chief_id", using: :btree
  add_index "departments", ["name"], name: "index_departments_on_name", unique: true, using: :btree

  create_table "firecars", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.float    "size",       limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "operations", force: :cascade do |t|
    t.string   "operation_type", limit: 255
    t.boolean  "activ",                      null: false
    t.datetime "time_started"
    t.integer  "address_id",     limit: 4
    t.integer  "department_id",  limit: 4
    t.integer  "chief_id",       limit: 4
  end

  add_index "operations", ["address_id"], name: "index_operations_on_address_id", using: :btree
  add_index "operations", ["chief_id"], name: "index_operations_on_chief_id", using: :btree
  add_index "operations", ["department_id"], name: "index_operations_on_department_id", using: :btree

  create_table "professions", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "professions", ["name"], name: "index_professions_on_name", unique: true, using: :btree

  create_table "professions_users", id: false, force: :cascade do |t|
    t.integer "profession_id", limit: 4
    t.integer "user_id",       limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname",        limit: 255, null: false
    t.string   "lastname",         limit: 255, null: false
    t.string   "password_digest",  limit: 255, null: false
    t.string   "remember_digest",  limit: 255
    t.string   "email",            limit: 255, null: false
    t.string   "phone_number",     limit: 255
    t.boolean  "admin",                        null: false
    t.string   "picture",          limit: 255
    t.float    "size",             limit: 24
    t.boolean  "female"
    t.string   "information",      limit: 255
    t.string   "view_device_type", limit: 255
    t.datetime "last_activ"
    t.integer  "profession_id",    limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "department_id",    limit: 4
  end

  add_index "users", ["department_id"], name: "index_users_on_department_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "departments", "addresses"
  add_foreign_key "operations", "addresses"
  add_foreign_key "operations", "departments"
  add_foreign_key "users", "departments"
end
