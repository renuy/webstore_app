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

ActiveRecord::Schema.define(:version => 20110430084814) do

  create_table "batches", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_lists", :force => true do |t|
    t.integer  "user_id",    :precision => 38, :scale => 0
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_lists", ["user_id", "category"], :name => "book_lists_idx1"

  create_table "collection_names", :force => true do |t|
    t.string   "name"
    t.string   "serialized"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", :force => true do |t|
    t.integer  "titles_id",          :precision => 38, :scale => 0
    t.integer  "series_id",          :precision => 38, :scale => 0
    t.integer  "collection_name_id", :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devise_users", :force => true do |t|
    t.string   "email",                                                              :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128,                                :default => "", :null => false
    t.string   "password_salt",                                                      :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :precision => 38, :scale => 0, :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "devise_users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "devise_users", ["reset_password_token"], :name => "i_users_reset_password_token", :unique => true

  create_table "favourites", :force => true do |t|
    t.integer "user_id",   :precision => 38, :scale => 0
    t.string  "favourite"
    t.integer "item_id",   :precision => 38, :scale => 0
    t.integer "rank",      :precision => 38, :scale => 0
  end

  create_table "items", :force => true do |t|
    t.integer  "order_id",   :precision => 38, :scale => 0
    t.integer  "title_id",   :precision => 38, :scale => 0
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_items", :force => true do |t|
    t.integer  "book_list_id", :precision => 38, :scale => 0
    t.integer  "title_id",     :precision => 38, :scale => 0
    t.integer  "member_id",    :precision => 38, :scale => 0
    t.integer  "shelf_id",     :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "member_id",   :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id",   :precision => 38, :scale => 0
    t.string   "state"
    t.string   "order_for"
    t.string   "description"
    t.integer  "user_id",     :precision => 38, :scale => 0
    t.string   "channel"
    t.string   "card_id"
    t.string   "charge"
    t.decimal  "amount"
    t.integer  "payment_id",  :precision => 38, :scale => 0
  end

  create_table "payments", :force => true do |t|
    t.integer  "order_id",    :precision => 38, :scale => 0
    t.string   "state"
    t.integer  "orig_id",     :precision => 38, :scale => 0
    t.decimal  "amount"
    t.string   "mode"
    t.string   "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "fee"
    t.string   "channel"
    t.integer  "branch_id",   :precision => 38, :scale => 0
    t.integer  "user_id",     :precision => 38, :scale => 0
    t.integer  "member_id",   :precision => 38, :scale => 0
    t.string   "payment_for"
    t.decimal  "txn_amount"
  end

  create_table "pending_titles_for_collections", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "renewals", :force => true do |t|
    t.integer  "payment_id", :precision => 38, :scale => 0
    t.integer  "months",     :precision => 38, :scale => 0
    t.datetime "from_date"
    t.datetime "to_date"
    t.string   "card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id",  :precision => 38, :scale => 0
    t.decimal  "amount"
    t.string   "state"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id",                     :precision => 38, :scale => 0
    t.integer  "title_id",                    :precision => 38, :scale => 0
    t.string   "heading"
    t.string   "description", :limit => 1024
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "serialised_titles", :force => true do |t|
    t.integer  "titles_id",  :precision => 38, :scale => 0
    t.integer  "series_id",  :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series", :force => true do |t|
    t.string   "name"
    t.integer  "count_of_titles", :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestions", :force => true do |t|
    t.integer  "title_id",   :precision => 38, :scale => 0
    t.integer  "by_id",      :precision => 38, :scale => 0
    t.integer  "to_id",      :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_synonym "users_seq", "jbprod.profile_id_seq", :force => true

end
