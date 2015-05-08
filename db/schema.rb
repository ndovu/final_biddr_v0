ActiveRecord::Schema.define(version: 20150508163723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "title"
    t.text     "description"
    t.datetime "ends_on"
    t.integer  "reserve_price"
  end

end
