class CreateGuesses < ActiveRecord::Migration[6.1]
  def change
    create_table :guesses do |t|
      t.references :game_session, null: false, foreign_key: true
      t.string :word
      t.integer :frequency

      t.timestamps
    end
  end
end
