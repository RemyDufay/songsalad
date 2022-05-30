class GameSession < ApplicationRecord
  belongs_to :guest
  belongs_to :game
  has_many :guesses
  has_many :game_songs, through: :games
  has_many :songs, through: :game_songs

end
