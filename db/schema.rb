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

ActiveRecord::Schema.define(version: 20170116062634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string   "attachable_type",                       null: false
    t.integer  "attachable_id",                         null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.boolean  "is_deleted",            default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_id"], name: "index_attachments_on_attachable_id", using: :btree
  add_index "attachments", ["attachable_type"], name: "index_attachments_on_attachable_type", using: :btree

  create_table "buildings", force: :cascade do |t|
    t.string   "name"
    t.string   "building_access"
    t.string   "address"
    t.string   "slug"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "district"
  end

  create_table "channels", force: :cascade do |t|
    t.integer  "building_id"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "channel_type"
    t.integer  "created_by"
    t.text     "description"
  end

  add_index "channels", ["building_id"], name: "index_channels_on_building_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["message_id"], name: "index_comments_on_message_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "building_id"
    t.integer  "invitee_id"
    t.integer  "inviter_id"
    t.string   "invitee_email"
    t.string   "invitee_token"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "invitations", ["building_id"], name: "index_invitations_on_building_id", using: :btree

  create_table "item_photos", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "item_photos", ["item_id"], name: "index_item_photos_on_item_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.boolean  "sold"
    t.string   "category"
    t.string   "title"
    t.text     "description"
    t.float    "price"
    t.string   "location"
    t.string   "photo"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "leads", force: :cascade do |t|
    t.string   "phone"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "code"
    t.string   "address"
    t.string   "floor"
    t.string   "door"
    t.text     "command"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "building_id"
    t.integer  "user_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "channel_id"
    t.string   "photo"
    t.string   "original_filename"
    t.text     "users_like_id"
    t.boolean  "as_vote_option"
    t.string   "option_1"
    t.string   "option_2"
    t.string   "option_3"
    t.text     "vote_for_option_1"
    t.text     "vote_for_option_2"
    t.text     "vote_for_option_3"
    t.boolean  "validated",         default: true
    t.string   "option_4"
    t.string   "option_5"
    t.text     "vote_for_option_4"
    t.text     "vote_for_option_5"
  end

  create_table "missions", force: :cascade do |t|
    t.text     "description"
    t.string   "price"
    t.string   "category"
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "missions", ["user_id"], name: "index_missions_on_user_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.text     "description"
    t.string   "title"
    t.string   "category"
    t.string   "price"
    t.string   "mobile_phone"
    t.boolean  "show_mobile_phone"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "user_channels", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "channel_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "messages_seen"
    t.boolean  "want_notification", default: true
  end

  add_index "user_channels", ["channel_id"], name: "index_user_channels_on_channel_id", using: :btree
  add_index "user_channels", ["user_id"], name: "index_user_channels_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "building_id"
    t.string   "building_access"
    t.integer  "image_id"
    t.boolean  "admin",                  default: false
    t.string   "token"
    t.boolean  "gardien",                default: false
    t.string   "pseudo"
    t.integer  "floor"
    t.string   "door"
    t.string   "age"
    t.string   "sex"
    t.string   "user_status"
    t.string   "photo"
    t.text     "private_channel_ids"
  end

  add_index "users", ["building_id"], name: "index_users_on_building_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "channels", "buildings"
  add_foreign_key "comments", "messages"
  add_foreign_key "comments", "users"
  add_foreign_key "invitations", "buildings"
  add_foreign_key "item_photos", "items"
  add_foreign_key "items", "users"
  add_foreign_key "missions", "users"
  add_foreign_key "services", "users"
  add_foreign_key "user_channels", "channels"
  add_foreign_key "user_channels", "users"
end
