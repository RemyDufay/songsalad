class CreateGameSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :game_songs do |t|
      t.references :song, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
