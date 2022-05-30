class GameSong < ApplicationRecord
  belongs_to :song
  belongs_to :game
end
