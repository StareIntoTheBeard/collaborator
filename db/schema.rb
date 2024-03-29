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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121120020406) do

  create_table "apps", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "image"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "appurl",      :default => ""
  end

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "task_id"
  end

  create_table "attachments", :force => true do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "topic_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.text     "modifications"
    t.string   "action"
    t.string   "tag"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "audits", ["action"], :name => "index_audits_on_action"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["tag"], :name => "index_audits_on_tag"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "project_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "enabled",    :default => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.integer  "org_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "repo"
    t.text     "description"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.datetime "edit_date"
    t.datetime "date_updated_on"
    t.decimal  "retainer_hours"
    t.date     "retainer_expiration"
    t.string   "auto_tag",            :default => "Client-Visible"
    t.string   "url"
    t.integer  "overage"
    t.string   "ptype",               :default => "Site"
  end

  create_table "projects_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "settings", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "subscribable_id"
    t.string   "subscribable_type"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "user_id"
    t.boolean  "enabled",           :default => true
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.string   "time",                       :default => "0.0"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.integer  "topic_id"
    t.boolean  "billable"
    t.text     "changetag",   :limit => 255, :default => "Task Created."
    t.boolean  "wasbilled",                  :default => false
  end

  create_table "tasks_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "task_id"
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.integer  "project_id"
    t.decimal  "hoursreq"
    t.decimal  "hoursused"
    t.integer  "work_status",             :default => 1
    t.string   "topic_tag",               :default => "New Topic,newtopictag"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "report_lastpage",         :default => "None"
    t.string   "report_environment",      :default => "None"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "organization_id"
    t.boolean  "blocked",                :default => false
    t.boolean  "topicmail",              :default => true
    t.string   "firstname",              :default => ""
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wikis", :force => true do |t|
    t.string   "title",        :default => ""
    t.text     "body",         :default => ""
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "slug"
    t.string   "changetag",    :default => "Article Created."
    t.string   "postcategory", :default => ""
  end

  add_index "wikis", ["slug"], :name => "index_wikis_on_slug", :unique => true

end
