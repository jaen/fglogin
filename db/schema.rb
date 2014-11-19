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

ActiveRecord::Schema.define(version: 20141118105215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: true do |t|
    t.integer  "customer_id"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "street_address"
    t.string   "suite"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["customer_id"], name: "index_addresses_on_customer_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "customers", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true, using: :btree
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree

  create_table "preferences", force: true do |t|
    t.integer  "subscription_id"
    t.integer  "track_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preferences", ["subscription_id"], name: "index_preferences_on_subscription_id", using: :btree
  add_index "preferences", ["track_id"], name: "index_preferences_on_track_id", using: :btree

  create_table "profile_updates", force: true do |t|
    t.integer  "state"
    t.integer  "customer_id"
    t.text     "lunch",       array: true
    t.text     "dinner",      array: true
    t.text     "extra_notes"
    t.time     "lunch_time"
    t.time     "dinner_time"
    t.integer  "address_id"
    t.integer  "tracks",      array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_updates", ["address_id"], name: "index_profile_updates_on_address_id", using: :btree
  add_index "profile_updates", ["customer_id"], name: "index_profile_updates_on_customer_id", using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer  "customer_id"
    t.text     "lunch"
    t.text     "dinner"
    t.string   "upcoming_meal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "extra_notes"
    t.time     "lunch_time"
    t.time     "dinner_time"
  end

  add_index "subscriptions", ["customer_id"], name: "index_subscriptions_on_customer_id", using: :btree

  create_table "tracks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "description"
  end

end
