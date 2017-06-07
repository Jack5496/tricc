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

ActiveRecord::Schema.define(version: 20170000001010) do

  create_table "addresses", force: :cascade do |t|
    t.string   "city"
    t.integer  "postcode",          null: false
    t.string   "street",            null: false
    t.integer  "building_number",   null: false
    t.string   "secondary_address"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "addresses", ["postcode", "street", "building_number"], name: "index_addresses_on_postcode_and_street_and_building_number", unique: true

  create_table "departments", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "name",       null: false
    t.integer  "address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "departments", ["name"], name: "index_departments_on_name", unique: true

  create_table "operations", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.boolean  "activ",         null: false
    t.integer  "department_id", null: false
    t.datetime "time_started"
  end

  create_table "professions", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "professions", ["name"], name: "index_professions_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "firstname",       null: false
    t.string   "lastname",        null: false
    t.string   "password_digest", null: false
    t.string   "remember_digest"
    t.string   "email",           null: false
    t.boolean  "admin",           null: false
    t.string   "picture"
    t.float    "size"
    t.boolean  "female"
    t.string   "information"
    t.string   "device_type"
    t.datetime "last_activ"
    t.integer  "profession_id"
    t.integer  "department_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
