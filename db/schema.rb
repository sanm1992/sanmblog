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

ActiveRecord::Schema.define(version: 2019_01_14_063625) do

  create_table "article_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 64, null: false, comment: "名称"
    t.string "code", limit: 64, null: false, comment: "英文简称"
    t.boolean "enabled", default: true, null: false, comment: "有效状态"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "tag", limit: 32
    t.string "title", null: false
    t.text "content", null: false
    t.integer "reading_time", default: 0, null: false
    t.string "category", default: "tec"
    t.text "attachment"
    t.boolean "enabled", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "user_name", limit: 32, null: false
    t.string "email", limit: 32, null: false
    t.text "content", null: false
    t.integer "floor", default: 1, null: false
    t.boolean "enabled", default: true, null: false
    t.integer "reply_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "article_id"
    t.index ["article_id"], name: "index_comments_on_article_id"
  end

  create_table "photos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "oss_url", null: false
    t.boolean "enabled", default: true, null: false
    t.text "note"
    t.string "category", limit: 64, default: "daily", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.string "password_digest", null: false
    t.string "email", limit: 32
    t.datetime "last_sign_time"
    t.string "authentication_token"
    t.integer "sign_times", default: 0, null: false
    t.boolean "enabled", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "articles"
end
