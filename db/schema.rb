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

ActiveRecord::Schema.define(version: 2025_05_19_012554) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_users", force: :cascade do |t|
    t.string "name", comment: "姓名"
    t.string "mobile", comment: "手机号"
    t.integer "sex", comment: "性别"
    t.integer "app_user_type", comment: "账号类型"
    t.datetime "login_at", comment: "登录时间"
    t.integer "sub_firm_id", comment: "所属公司"
    t.text "notes", comment: "备注"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_user_type"], name: "index_app_users_on_app_user_type"
    t.index ["mobile"], name: "index_app_users_on_mobile", unique: true
    t.index ["sub_firm_id"], name: "index_app_users_on_sub_firm_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["teacher_id"], name: "index_students_on_teacher_id"
  end

  create_table "sub_firms", force: :cascade do |t|
    t.string "firm_name", comment: "公司名称"
    t.float "registered_capital", comment: "注册资本"
    t.string "address", comment: "公司地址"
    t.boolean "active", default: true, comment: "是否激活"
    t.integer "firm_property", comment: "公司性质"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_sub_firms_on_active"
  end

  create_table "teacher_structures", force: :cascade do |t|
    t.integer "teacher_id"
    t.integer "super_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age", comment: "年龄"
    t.string "descriotion", comment: "所教课程"
    t.boolean "is_free"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", comment: "用户名"
    t.integer "sex", comment: "性别"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
