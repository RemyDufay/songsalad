class Guess < ApplicationRecord
  belongs_to :game_session_song
  validates :word, presence: true
end
