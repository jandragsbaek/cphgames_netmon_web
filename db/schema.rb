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

ActiveRecord::Schema.define(version: 20160323191934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "datapoints", force: :cascade do |t|
    t.integer  "switch_id"
    t.integer  "port"
    t.string   "direction"
    t.decimal  "speed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "datapoints", ["switch_id"], name: "index_datapoints_on_switch_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "heartbeat", id: false, force: :cascade do |t|
    t.text     "ip"
    t.boolean  "alive",      default: false
    t.integer  "uptime"
    t.datetime "updated_at"
  end

  create_table "readings", force: :cascade do |t|
    t.integer  "bytes",      limit: 8
    t.integer  "switch_id"
    t.integer  "port",                 default: 0
    t.string   "direction",            default: "in"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "readings", ["switch_id"], name: "index_readings_on_switch_id", using: :btree

  create_table "switches", force: :cascade do |t|
    t.string   "source"
    t.string   "destination"
    t.integer  "uptime"
    t.string   "ip"
    t.string   "description"
    t.boolean  "alive"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id",       default: 1
    t.datetime "parsed_at"
    t.decimal  "in_speed",       default: 0.0
    t.decimal  "out_speed",      default: 0.0
    t.datetime "latest_data_at", default: '2006-03-23 01:59:33'
    t.decimal  "bandwidth_down", default: 0.0
    t.decimal  "bandwidth_up",   default: 0.0
    t.boolean  "bigint",         default: true
  end

end
