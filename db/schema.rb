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

ActiveRecord::Schema.define(version: 2022_06_01_210324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_session_songs", force: :cascade do |t|
    t.bigint "game_session_id", null: false
    t.bigint "game_song_id", null: false
    t.jsonb "guessed_lyrics_index", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.index ["game_session_id"], name: "index_game_session_songs_on_game_session_id"
    t.index ["game_song_id"], name: "index_game_session_songs_on_game_song_id"
  end

  create_table "game_sessions", force: :cascade do |t|
    t.bigint "guest_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "victory?"
    t.index ["game_id"], name: "index_game_sessions_on_game_id"
    t.index ["guest_id"], name: "index_game_sessions_on_guest_id"
  end

  create_table "game_songs", force: :cascade do |t|
    t.bigint "song_id", null: false
    t.bigint "game_id", null: false
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_game_songs_on_game_id"
    t.index ["song_id"], name: "index_game_songs_on_song_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "guesses", force: :cascade do |t|
    t.string "word"
    t.integer "frequency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_session_song_id"
    t.index ["game_session_song_id"], name: "index_guesses_on_game_session_song_id"
  end

  create_table "guests", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "lyrics"
    t.string "author"
    t.string "title"
    t.string "genre"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "splitted_lyrics", default: []
    t.jsonb "lyrics_index", default: {}
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "game_session_songs", "game_sessions"
  add_foreign_key "game_session_songs", "game_songs"
  add_foreign_key "game_sessions", "games"
  add_foreign_key "game_sessions", "guests"
  add_foreign_key "game_songs", "games"
  add_foreign_key "game_songs", "songs"
  add_foreign_key "guesses", "game_session_songs"
end
