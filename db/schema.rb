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

ActiveRecord::Schema.define(version: 2019_06_11_135715) do

  create_table "addresses", force: :cascade do |t|
    t.string "jis"
    t.string "former_zipcode"
    t.string "zipcode"
    t.string "prefecture_phonetic"
    t.string "city_phonetic"
    t.string "town_area_phonetic"
    t.string "additional_area_phonetic"
    t.string "prefecture"
    t.string "city"
    t.string "town_area"
    t.string "additional_area"
    t.string "prefecture_city_town_area"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prefecture_city_town_area"], name: "index_addresses_on_prefecture_city_town_area"
    t.index ["zipcode"], name: "index_addresses_on_zipcode"
  end

end
