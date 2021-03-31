# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_29_144217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'crime_entries', force: :cascade do |t|
    t.bigint 'location_id', null: false
    t.string 'name', null: false
    t.integer 'value', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.date 'month', null: false
    t.index ['location_id'], name: 'index_crime_entries_on_location_id'
  end

  create_table 'locations', force: :cascade do |t|
    t.string 'name', null: false, unique: true
    t.date 'updated', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'crime_entries', 'locations'
end
