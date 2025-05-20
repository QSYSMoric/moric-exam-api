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

ActiveRecord::Schema.define(version: 2025_05_20_034022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name", comment: "公司名"
    t.string "phone", comment: "公司联系电话"
    t.string "address", comment: "公司地址"
    t.string "post_code", comment: "邮编"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "follow_person_id", comment: "跟进人"
    t.index ["follow_person_id"], name: "index_companies_on_follow_person_id"
    t.index ["name"], name: "index_companies_on_name"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", comment: "姓名"
    t.string "gender", comment: "性别"
    t.string "importance", comment: "重要性"
    t.string "department", comment: "部门"
    t.string "phones", default: [], comment: "手机", array: true
    t.string "telephone", comment: "电话"
    t.string "email", comment: "邮箱"
    t.string "remark", comment: "备注"
    t.bigint "company_id", comment: "所属公司"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_contacts_on_company_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "time", comment: "安排时间"
    t.text "remark", comment: "备注"
    t.string "stage", comment: "阶段"
    t.integer "state", default: 0, comment: "状态"
    t.bigint "company_id", comment: "所属公司"
    t.bigint "contact_id", comment: "联系人"
    t.bigint "user_id", comment: "跟进人"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_tasks_on_company_id"
    t.index ["contact_id"], name: "index_tasks_on_contact_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", comment: "姓名"
    t.string "gender", comment: "性别"
    t.integer "role", comment: "角色"
    t.string "password_digest", comment: "密码"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "companies", "users", column: "follow_person_id"
  add_foreign_key "contacts", "companies"
  add_foreign_key "tasks", "companies"
  add_foreign_key "tasks", "contacts"
  add_foreign_key "tasks", "users"
end
