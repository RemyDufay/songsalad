class GameSession < ApplicationRecord
  belongs_to :guest
  belongs_to :game
end
