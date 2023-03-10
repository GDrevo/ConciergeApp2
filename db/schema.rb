# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_17_001127) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "cleaner_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rooms"
    t.string "service"
    t.float "estimated_time"
    t.integer "price"
    t.string "checkin_type"
    t.string "pack"
    t.datetime "checkin_start_time"
    t.datetime "checkin_end_time"
    t.bigint "checkin_cleaner_id"
    t.datetime "checkout_start_time"
    t.datetime "checkout_end_time"
    t.bigint "checkout_cleaner_id"
    t.index ["checkin_cleaner_id"], name: "index_appointments_on_checkin_cleaner_id"
    t.index ["checkout_cleaner_id"], name: "index_appointments_on_checkout_cleaner_id"
    t.index ["cleaner_id"], name: "index_appointments_on_cleaner_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "cleaner_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cleaner_id"], name: "index_availabilities_on_cleaner_id"
  end

  create_table "checkins", force: :cascade do |t|
    t.string "check_type"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id", null: false
    t.bigint "cleaner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration", default: 1
    t.integer "price", default: 25
    t.index ["cleaner_id"], name: "index_checkins_on_cleaner_id"
    t.index ["user_id"], name: "index_checkins_on_user_id"
  end

  create_table "cleaners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "description"
    t.integer "phone"
    t.string "gender"
    t.string "location"
    t.string "qualification"
    t.string "experience"
    t.integer "days_per_week"
    t.boolean "work_permit?"
    t.boolean "full_time?"
    t.boolean "confirmed?"
    t.index ["email"], name: "index_cleaners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_cleaners_on_reset_password_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "cleaners"
  add_foreign_key "appointments", "cleaners", column: "checkin_cleaner_id"
  add_foreign_key "appointments", "cleaners", column: "checkout_cleaner_id"
  add_foreign_key "appointments", "users"
  add_foreign_key "availabilities", "cleaners"
  add_foreign_key "checkins", "cleaners"
  add_foreign_key "checkins", "users"
end
