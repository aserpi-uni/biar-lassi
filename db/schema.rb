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

ActiveRecord::Schema.define(version: 20180206154930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admins_on_unlock_token", unique: true
    t.index ["username"], name: "index_admins_on_username", unique: true
  end

  create_table "advice_threads", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.bigint "author_id"
    t.integer "votes", default: 0
    t.integer "status", default: 0
    t.index ["author_id"], name: "index_advice_threads_on_author_id"
    t.index ["product_id"], name: "index_advice_threads_on_product_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "problem_thread_id"
    t.string "author_type"
    t.bigint "author_id"
    t.boolean "solution"
    t.integer "votes", default: 0
    t.string "domain_type"
    t.bigint "domain_id"
    t.index ["author_type", "author_id"], name: "index_comments_on_author_type_and_author_id"
    t.index ["domain_type", "domain_id"], name: "index_comments_on_domain_type_and_domain_id"
    t.index ["problem_thread_id"], name: "index_comments_on_problem_thread_id"
  end

  create_table "consumers", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "email"
    t.text "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_consumers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_consumers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_consumers_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_consumers_on_uid"
    t.index ["unlock_token"], name: "index_consumers_on_unlock_token", unique: true
    t.index ["username"], name: "index_consumers_on_username", unique: true
  end

  create_table "down_votes", force: :cascade do |t|
    t.string "downer_type"
    t.bigint "downer_id"
    t.string "downable_type"
    t.bigint "downable_id"
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["downable_type", "downable_id"], name: "index_down_votes_on_downable_type_and_downable_id"
    t.index ["downer_type", "downer_id"], name: "index_down_votes_on_downer_type_and_downer_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.string "email"
    t.bigint "enterprise_id"
    t.integer "assigned_problems"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["enterprise_id"], name: "index_employees_on_enterprise_id"
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_employees_on_unlock_token", unique: true
    t.index ["username"], name: "index_employees_on_username", unique: true
  end

  create_table "enterprises", force: :cascade do |t|
    t.text "name"
    t.text "username_suffix"
    t.text "description"
    t.text "headquarters"
    t.text "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "founded"
    t.boolean "active", default: true
    t.string "image_data"
    t.string "avatar_operator_data"
    t.string "avatar_supervisor_data"
    t.index ["name"], name: "index_enterprises_on_name", unique: true
  end

  create_table "problem_threads", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.bigint "author_id"
    t.bigint "employee_id"
    t.integer "votes", default: 0
    t.index ["author_id"], name: "index_problem_threads_on_author_id"
    t.index ["employee_id"], name: "index_problem_threads_on_employee_id"
    t.index ["product_id"], name: "index_problem_threads_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "model"
    t.text "description"
    t.integer "production_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "enterprise_id"
    t.boolean "active"
    t.string "image_data"
    t.index ["enterprise_id"], name: "index_products_on_enterprise_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "consumer_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "followed_type"
    t.index ["consumer_id", "followed_id"], name: "index_relationships_on_consumer_id_and_followed_id", unique: true
    t.index ["consumer_id"], name: "index_relationships_on_consumer_id"
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
  end

  create_table "up_votes", force: :cascade do |t|
    t.string "upper_type"
    t.bigint "upper_id"
    t.string "uppable_type"
    t.bigint "uppable_id"
    t.index ["uppable_type", "uppable_id"], name: "index_up_votes_on_uppable_type_and_uppable_id"
    t.index ["upper_type", "upper_id"], name: "index_up_votes_on_upper_type_and_upper_id"
  end

  add_foreign_key "advice_threads", "consumers", column: "author_id"
  add_foreign_key "advice_threads", "products"
  add_foreign_key "comments", "problem_threads"
  add_foreign_key "employees", "enterprises"
  add_foreign_key "problem_threads", "consumers", column: "author_id"
  add_foreign_key "problem_threads", "employees"
  add_foreign_key "problem_threads", "products"
  add_foreign_key "products", "enterprises"
end
