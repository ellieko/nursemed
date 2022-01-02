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

ActiveRecord::Schema.define(version: 20211208230302) do

  create_table "administrators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adverse_effects", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "adverse_effects_medications", id: false, force: :cascade do |t|
    t.integer "adverse_effect_id", null: false
    t.integer "medication_id",     null: false
  end

  create_table "guardians", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guardians_students", id: false, force: :cascade do |t|
    t.integer "guardian_id", null: false
    t.integer "student_id",  null: false
  end

  create_table "medication_assignments", force: :cascade do |t|
    t.integer  "nurse_id"
    t.integer  "student_id"
    t.integer  "medication_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "frequency"
    t.string   "amount"
    t.string   "description"
  end

  add_index "medication_assignments", ["medication_id"], name: "index_medication_assignments_on_medication_id"
  add_index "medication_assignments", ["nurse_id"], name: "index_medication_assignments_on_nurse_id"
  add_index "medication_assignments", ["student_id"], name: "index_medication_assignments_on_student_id"

  create_table "medications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "dosage"
    t.string   "true_name"
  end

  create_table "meetings", force: :cascade do |t|
    t.integer  "nurse_id"
    t.integer  "student_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "error"
    t.string   "errorType"
    t.string   "mitigation"
    t.string   "info"
    t.datetime "start"
    t.string   "log",        default: "false"
  end

  add_index "meetings", ["nurse_id"], name: "index_meetings_on_nurse_id"
  add_index "meetings", ["student_id"], name: "index_meetings_on_student_id"

  create_table "nurses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "school_id"
  end

  add_index "nurses", ["school_id"], name: "index_nurses_on_school_id"

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.date     "birthdate"
    t.integer  "school_id"
    t.integer  "medication_assignment_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "nurse_id"
    t.integer  "student_id"
    t.integer  "administrator_id"
    t.integer  "guardian_id"
    t.string   "session_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "users", ["administrator_id"], name: "index_users_on_administrator_id"
  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["guardian_id"], name: "index_users_on_guardian_id"
  add_index "users", ["nurse_id"], name: "index_users_on_nurse_id"
  add_index "users", ["session_token"], name: "index_users_on_session_token"
  add_index "users", ["student_id"], name: "index_users_on_student_id"

end
