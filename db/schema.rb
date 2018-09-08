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

ActiveRecord::Schema.define(version: 2018_09_08_160919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "availabilities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hotel_id", null: false
    t.uuid "room_type_id", null: false
    t.integer "available_rooms", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "availability_date", null: false
    t.index ["hotel_id", "availability_date"], name: "index_availabilities_on_hotel_id_and_availability_date"
    t.index ["hotel_id", "room_type_id"], name: "index_availabilities_on_hotel_id_and_room_type_id"
    t.index ["room_type_id", "availability_date"], name: "index_availabilities_on_room_type_id_and_availability_date", unique: true
    t.index ["room_type_id", "hotel_id"], name: "index_availabilities_on_room_type_id_and_hotel_id"
  end

  create_table "bookings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "hotel_id", null: false
    t.date "checkin", null: false
    t.date "checkout", null: false
    t.float "monthly_rent", default: 0.0, null: false
    t.float "rent", default: 0.0, null: false
    t.integer "status", default: 0, null: false
    t.uuid "room_type_id", null: false
    t.integer "number_of_rooms", default: 1, null: false
    t.json "meta_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checkin", "checkout"], name: "index_bookings_on_checkin_and_checkout"
    t.index ["checkout"], name: "index_bookings_on_checkout"
    t.index ["hotel_id"], name: "index_bookings_on_hotel_id"
    t.index ["status"], name: "index_bookings_on_status"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "clients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "auth_token", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
  end

  create_table "pricings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hotel_id", null: false
    t.uuid "room_type_id", null: false
    t.date "price_date", null: false
    t.float "price", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id", "price_date"], name: "index_pricings_on_hotel_id_and_price_date"
    t.index ["hotel_id", "room_type_id"], name: "index_pricings_on_hotel_id_and_room_type_id"
    t.index ["room_type_id", "price_date"], name: "index_pricings_on_room_type_id_and_price_date", unique: true
  end

  create_table "room_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "occupancy_limit", default: 1, null: false
    t.boolean "active", default: true, null: false
    t.integer "number_of_rooms", default: 0, null: false
    t.index ["hotel_id"], name: "index_room_types_on_hotel_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
