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

ActiveRecord::Schema.define(version: 20160919184020) do

  create_table "bookings", force: :cascade do |t|
    t.date     "date"
    t.integer  "user_id"
    t.integer  "hotel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["hotel_id"], name: "index_bookings_on_hotel_id"
    t.index ["id"], name: "index_bookings_on_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["id"], name: "index_hotels_on_id"
    t.index ["name"], name: "index_hotels_on_name"
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "code",       default: ""
    t.boolean  "is_expired"
    t.integer  "token_type"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["id"], name: "index_tokens_on_id"
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",              default: ""
    t.string   "encrypted_password", default: ""
    t.string   "salt",               default: ""
    t.datetime "confirmed_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["id"], name: "index_users_on_id"
  end

end
