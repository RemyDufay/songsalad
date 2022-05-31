class GameSessionSong < ApplicationRecord
  belongs_to :game_session
  belongs_to :game_song
  has_many :guesses
end
