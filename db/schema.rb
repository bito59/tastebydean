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

ActiveRecord::Schema.define(version: 20161002135505) do

  create_table "fabrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "serial"
    t.boolean  "activated",                                  default: false
    t.string   "kind"
    t.string   "title"
    t.string   "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.decimal  "price",              precision: 8, scale: 2
    t.string   "price_unit"
    t.boolean  "limited_fabric"
    t.integer  "stock_level"
    t.string   "stock_level_unit"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  create_table "friendly_id_slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "news", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "zipcode"
    t.string   "email"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_lines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "fabric_id"
    t.integer  "quantity"
    t.decimal  "unit_price",                 precision: 12, scale: 3
    t.decimal  "fabric_price",               precision: 12, scale: 3
    t.decimal  "total_price",                precision: 12, scale: 3
    t.decimal  "around_collar_large",        precision: 10
    t.decimal  "shoulder_width",             precision: 10
    t.decimal  "shoulder_waist_front_large", precision: 10
    t.decimal  "shoulder_waist_back_large",  precision: 10
    t.decimal  "back_width",                 precision: 10
    t.decimal  "chest_width",                precision: 10
    t.decimal  "around_bust_large",          precision: 10
    t.decimal  "bust_height",                precision: 10
    t.decimal  "around_waist_large",         precision: 10
    t.decimal  "elbow_length",               precision: 10
    t.decimal  "around_arm_large",           precision: 10
    t.decimal  "arm_lenght",                 precision: 10
    t.decimal  "around_hip_height",          precision: 10
    t.decimal  "around_hip_large",           precision: 10
    t.decimal  "half_hip_height",            precision: 10
    t.decimal  "crotch_length",              precision: 10
    t.decimal  "knee_lenght",                precision: 10
    t.decimal  "leg_length",                 precision: 10
    t.decimal  "inside_leg_length",          precision: 10
    t.decimal  "around_leg_large",           precision: 10
    t.decimal  "total_height",               precision: 10
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.index ["fabric_id"], name: "index_order_lines_on_fabric_id", using: :btree
    t.index ["order_id"], name: "index_order_lines_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_lines_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "serial"
    t.string   "status"
    t.string   "delivery_method"
    t.string   "title"
    t.string   "name"
    t.string   "surname"
    t.string   "address"
    t.string   "zipcode"
    t.string   "city"
    t.string   "country"
    t.string   "phone"
    t.decimal  "subtotal",          precision: 12, scale: 3
    t.decimal  "shipping_fees",     precision: 12, scale: 3
    t.decimal  "tax_fees",          precision: 12, scale: 3
    t.decimal  "share_discount",    precision: 10
    t.decimal  "num_discount",      precision: 10
    t.decimal  "total",             precision: 12, scale: 3
    t.string   "payment_method"
    t.string   "payment_type"
    t.string   "payment_status"
    t.datetime "creation_date"
    t.datetime "validation_date"
    t.datetime "confirmation_date"
    t.datetime "expedition_date"
    t.datetime "payment_date"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "product_pictures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id"
    t.boolean  "main"
    t.boolean  "activated"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["product_id"], name: "index_product_pictures_on_product_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "serial"
    t.boolean  "activated",                                             default: false
    t.string   "kind"
    t.string   "customer"
    t.string   "family"
    t.string   "title"
    t.text     "description",     limit: 65535
    t.decimal  "price",                         precision: 8, scale: 2
    t.string   "price_unit"
    t.boolean  "on_measure"
    t.boolean  "custom_fabric"
    t.float    "fab_length",      limit: 24
    t.string   "fab_length_unit"
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.string   "slug"
    t.index ["slug"], name: "index_products_on_slug", unique: true, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "zipcode"
    t.boolean  "newsletter",             default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "order_lines", "fabrics"
  add_foreign_key "order_lines", "orders"
  add_foreign_key "order_lines", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "product_pictures", "products"
end
