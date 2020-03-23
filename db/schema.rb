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

ActiveRecord::Schema.define(version: 20200323131300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "homes", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "status"
    t.integer "number_floors"
    t.integer "full_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.string "price_unit", default: "VND"
    t.text "address"
    t.index ["user_id", "created_at"], name: "index_homes_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_homes_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "home_id"
    t.datetime "checkin_time"
    t.integer "rental_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "order_status", default: "requesting"
    t.bigint "room_id"
    t.index ["home_id"], name: "index_orders_on_home_id"
    t.index ["room_id"], name: "index_orders_on_room_id"
    t.index ["user_id", "created_at"], name: "index_orders_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "user_id"
    t.bigint "home_id"
    t.integer "length"
    t.integer "width"
    t.integer "height"
    t.integer "number_room"
    t.integer "price"
    t.string "price_unit"
    t.string "status", default: "available "
    t.integer "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["home_id"], name: "index_rooms_on_home_id"
    t.index ["order_id"], name: "index_rooms_on_order_id"
    t.index ["user_id", "created_at"], name: "index_rooms_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.boolean "admin", default: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "homes", "users"
  add_foreign_key "orders", "homes"
  add_foreign_key "orders", "rooms"
  add_foreign_key "orders", "users"
  add_foreign_key "rooms", "homes"
  add_foreign_key "rooms", "orders"
  add_foreign_key "rooms", "users"
end
