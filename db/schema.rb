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

ActiveRecord::Schema.define(version: 20141001100503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "project_tags", force: true do |t|
    t.integer  "project_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_tags", ["project_id"], name: "index_project_tags_on_project_id", using: :btree
  add_index "project_tags", ["tag_id"], name: "index_project_tags_on_tag_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "full_name"
    t.text     "description"
    t.integer  "github_id"
    t.string   "homepage"
    t.integer  "stargazers_count"
    t.integer  "watchers_count"
    t.integer  "forks_count"
    t.integer  "subscribers_count"
    t.integer  "parent_id"
    t.integer  "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "github_pushed_at"
    t.datetime "github_created_at"
    t.string   "slug"
    t.integer  "points",            default: 0
    t.boolean  "is_gem",            default: false
    t.boolean  "is_app",            default: false
    t.integer  "hottness",          default: 0
    t.string   "rubygem_name"
    t.integer  "user_id"
    t.integer  "owner_id"
  end

  add_index "projects", ["rubygem_name"], name: "index_projects_on_rubygem_name", unique: true, using: :btree
  add_index "projects", ["slug"], name: "index_projects_on_slug", unique: true, using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "stats", force: true do |t|
    t.integer  "project_id"
    t.integer  "stargazers_count"
    t.integer  "subscribers_count"
    t.integer  "forks_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stats", ["project_id"], name: "index_stats_on_project_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.integer  "projects_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "is_accepted",    default: false
  end

  add_index "tags", ["slug"], name: "index_tags_on_slug", unique: true, using: :btree

  create_table "user_services", force: true do |t|
    t.integer  "uid"
    t.integer  "user_id"
    t.string   "provider"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_services", ["user_id"], name: "index_user_services_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",               default: ""
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "name"
  end

end
