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

ActiveRecord::Schema.define(version: 2021_06_22_061111) do

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.string "hometown"
    t.string "birthday"
    t.string "deathday"
  end

  create_table "paintings", force: :cascade do |t|
    t.string "image", null: false
    t.string "title", null: false
    t.string "date"
    t.string "dimensions_text"
    t.float "width"
    t.float "height"
    t.string "collection_institution"
    t.float "depth"
    t.float "diameter"
    t.string "slug"
    t.integer "votes"
    t.integer "artist_id"
    t.index ["artist_id"], name: "index_paintings_on_artist_id"
  end

end
