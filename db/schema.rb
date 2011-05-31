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

ActiveRecord::Schema.define(:version => 20110531065917) do

  create_table "book_lists", :force => true do |t|
    t.integer  "user_id",    :precision => 38, :scale => 0
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_lists", ["user_id", "category"], :name => "book_lists_idx"

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

  create_table "payments", :force => true do |t|
    t.integer   "order_id",                 :precision => 38, :scale => 0
    t.string    "state"
    t.integer   "orig_id",                  :precision => 38, :scale => 0
    t.integer   "amount",                   :precision => 38, :scale => 0
    t.string    "p_mode"
    t.string    "details"
    t.timestamp "created_at",  :limit => 6
    t.timestamp "updated_at",  :limit => 6
    t.integer   "fee",                      :precision => 38, :scale => 0
    t.string    "channel"
    t.integer   "branch_id",                :precision => 38, :scale => 0
    t.integer   "user_id",                  :precision => 38, :scale => 0
    t.integer   "member_id",                :precision => 38, :scale => 0
    t.string    "payment_for"
    t.integer   "txn_amount",               :precision => 38, :scale => 0
  end

  create_table "pending_titles_for_collections", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", :force => true do |t|
    t.integer  "title_id",   :precision => 38, :scale => 0
    t.string   "question"
    t.string   "answer"
    t.string   "cue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "option_1"
    t.string   "option_2"
    t.string   "option_3"
  end

  create_table "ratings", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "renewals", :force => true do |t|
    t.integer   "payment_id",              :precision => 38, :scale => 0
    t.integer   "months",                  :precision => 38, :scale => 0
    t.datetime  "from_date"
    t.datetime  "to_date"
    t.string    "card_id"
    t.timestamp "created_at", :limit => 6
    t.timestamp "updated_at", :limit => 6
    t.integer   "member_id",               :precision => 38, :scale => 0
    t.integer   "amount",                  :precision => 38, :scale => 0
    t.string    "state"
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

  create_table "signups", :force => true do |t|
    t.string   "name",                                                               :null => false
    t.string   "address",                                                            :null => false
    t.integer  "mphone",             :precision => 38, :scale => 0
    t.integer  "lphone",             :precision => 38, :scale => 0
    t.string   "email",                                                              :null => false
    t.string   "referrer_member_id"
    t.integer  "referrer_cust_id",   :precision => 38, :scale => 0
    t.integer  "plan_id",            :precision => 38, :scale => 0,                  :null => false
    t.integer  "branch_id",          :precision => 38, :scale => 0
    t.integer  "signup_months",      :precision => 38, :scale => 0,                  :null => false
    t.integer  "security_deposit",   :precision => 38, :scale => 0,                  :null => false
    t.integer  "registration_fee",   :precision => 38, :scale => 0,                  :null => false
    t.integer  "reading_fee",        :precision => 38, :scale => 0,                  :null => false
    t.integer  "discount",           :precision => 38, :scale => 0,                  :null => false
    t.integer  "advance_amt",        :precision => 38, :scale => 0,                  :null => false
    t.integer  "paid_amt",           :precision => 38, :scale => 0,                  :null => false
    t.integer  "overdue_amt",        :precision => 38, :scale => 0,                  :null => false
    t.integer  "payment_mode",       :precision => 38, :scale => 0,                  :null => false
    t.string   "payment_ref",                                                        :null => false
    t.string   "membership_no"
    t.string   "application_no"
    t.string   "employee_no"
    t.integer  "created_by",         :precision => 38, :scale => 0,                  :null => false
    t.integer  "modified_by",        :precision => 38, :scale => 0,                  :null => false
    t.string   "flag_migrated",                                     :default => "U"
    t.datetime "start_date",                                                         :null => false
    t.datetime "expiry_date",                                                        :null => false
    t.string   "remarks"
    t.string   "state"
    t.integer  "coupon_amt",         :precision => 38, :scale => 0
    t.string   "coupon_no"
    t.integer  "coupon_id",          :precision => 38, :scale => 0
    t.string   "flag_reversed"
    t.integer  "company_id",         :precision => 38, :scale => 0
    t.integer  "reversal_reason_id", :precision => 38, :scale => 0
    t.integer  "payment_id",         :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "info_source_id",     :precision => 38, :scale => 0
  end

  add_index "signups", ["membership_no", "flag_reversed", "id"], :name => "index1", :unique => true

  create_table "suggestions", :force => true do |t|
    t.integer  "title_id",   :precision => 38, :scale => 0
    t.integer  "by_id",      :precision => 38, :scale => 0
    t.integer  "to_id",      :precision => 38, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_synonym "memp_signups_seq", "signups_seq@link_memp", :force => true
  add_synonym "payments_seq", "order_id_seq@link_bangalore", :force => true
  add_synonym "users_seq", "profile_id_seq@link_bangalore", :force => true
  add_synonym "memp_signups", "signups@link_memp", :force => true
  add_synonym "memp_events", "events@link_memp", :force => true
  add_synonym "memp_events_seq", "events_seq@link_memp", :force => true

end
