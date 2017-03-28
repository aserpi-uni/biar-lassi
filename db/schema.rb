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

ActiveRecord::Schema.define(version: 20170328092321) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email"
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true, length: { confirmation_token: 191 }, using: :btree
    t.index ["email"], name: "index_admins_on_email", unique: true, length: { email: 191 }, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, length: { reset_password_token: 191 }, using: :btree
    t.index ["unlock_token"], name: "index_admins_on_unlock_token", unique: true, length: { unlock_token: 191 }, using: :btree
    t.index ["username"], name: "index_admins_on_username", unique: true, length: { username: 191 }, using: :btree
  end

  create_table "consumers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "email"
    t.index ["confirmation_token"], name: "index_consumers_on_confirmation_token", unique: true, length: { confirmation_token: 191 }, using: :btree
    t.index ["email"], name: "index_consumers_on_email", unique: true, length: { email: 191 }, using: :btree
    t.index ["reset_password_token"], name: "index_consumers_on_reset_password_token", unique: true, length: { reset_password_token: 191 }, using: :btree
    t.index ["uid"], name: "index_consumers_on_uid", length: { uid: 191 }, using: :btree
    t.index ["unlock_token"], name: "index_consumers_on_unlock_token", unique: true, length: { unlock_token: 191 }, using: :btree
    t.index ["username"], name: "index_consumers_on_username", unique: true, length: { username: 191 }, using: :btree
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role",                   default: 0
    t.string   "email"
    t.index ["email"], name: "index_employees_on_email", unique: true, length: { email: 191 }, using: :btree
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, length: { reset_password_token: 191 }, using: :btree
    t.index ["unlock_token"], name: "index_employees_on_unlock_token", unique: true, length: { unlock_token: 191 }, using: :btree
    t.index ["username"], name: "index_employees_on_username", unique: true, length: { username: 191 }, using: :btree
  end

end
