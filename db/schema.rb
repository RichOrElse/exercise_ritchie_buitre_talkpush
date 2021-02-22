# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_22_054503) do

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.string "spreadsheet_id", null: false
    t.json "import_candidates_failure"
    t.datetime "import_candidates_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "import_candidates_count", default: 0
    t.index ["name"], name: "index_campaigns_on_name"
    t.index ["spreadsheet_id"], name: "index_campaigns_on_spreadsheet_id", unique: true
  end

  create_table "candidate_creations", force: :cascade do |t|
    t.integer "campaign_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.json "response_body"
    t.integer "response_code"
    t.datetime "timestamp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_id"], name: "index_candidate_creations_on_campaign_id"
    t.index ["response_code"], name: "index_candidate_creations_on_response_code"
  end

  add_foreign_key "candidate_creations", "campaigns"
end
