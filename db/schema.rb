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

ActiveRecord::Schema.define(version: 20190704021742) do

  create_table "checks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id", "user_id"], name: "index_checks_on_comment_id_and_user_id", unique: true, using: :btree
    t.index ["comment_id"], name: "index_checks_on_comment_id", using: :btree
    t.index ["user_id"], name: "index_checks_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "comment"
    t.string   "tag"
    t.integer  "present_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["present_id"], name: "index_comments_on_present_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "mains", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.date     "date"
    t.string   "time"
    t.string   "group"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mains_on_user_id", using: :btree
  end

  create_table "presents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "name_read"
    t.string   "research"
    t.integer  "user_id"
    t.integer  "main_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["main_id"], name: "index_presents_on_main_id", using: :btree
    t.index ["user_id"], name: "index_presents_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "name_read"
    t.string   "research"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "checks", "comments"
  add_foreign_key "checks", "users"
  add_foreign_key "comments", "presents"
  add_foreign_key "comments", "users"
  add_foreign_key "mains", "users"
  add_foreign_key "presents", "mains"
  add_foreign_key "presents", "users"
end
