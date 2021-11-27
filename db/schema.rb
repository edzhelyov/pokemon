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

ActiveRecord::Schema.define(version: 2021_11_27_091425) do

  create_table "abilities", force: :cascade do |t|
    t.integer "original_id"
    t.string "name"
    t.text "flavors"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["original_id"], name: "index_abilities_on_original_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name"
    t.integer "height"
    t.integer "weight"
    t.integer "original_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["original_id"], name: "index_pokemons_on_original_id"
  end

  create_table "pokemons_types", id: false, force: :cascade do |t|
    t.integer "pokemon_id"
    t.integer "type_id"
    t.index ["pokemon_id"], name: "index_pokemons_types_on_pokemon_id"
    t.index ["type_id"], name: "index_pokemons_types_on_type_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.integer "original_id"
    t.string "move_damage_class"
    t.text "moves"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_types_on_name"
    t.index ["original_id"], name: "index_types_on_original_id"
  end

end
