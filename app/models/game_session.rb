class GameSession < ApplicationRecord
  belongs_to :guest, optional: true
  belongs_to :user, optional: true
  belongs_to :game
  has_many :game_session_songs
  has_many :game_songs, through: :game
  has_many :songs, through: :game_songs
end
