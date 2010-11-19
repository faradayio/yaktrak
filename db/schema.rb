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

ActiveRecord::Schema.define(:version => 20101119032314) do

  create_table "trackings", :id => false, :force => true do |t|
    t.string   "package_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zip_codes", :primary_key => "name", :force => true do |t|
    t.string    "state_postal_abbreviation"
    t.string    "description"
    t.string    "latitude"
    t.string    "longitude"
    t.string    "egrid_subregion_abbreviation"
    t.string    "climate_division_name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "zip_codes", ["name"], :name => "sqlite_autoindex_zip_codes_1", :unique => true

end
