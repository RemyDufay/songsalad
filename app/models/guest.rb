class Guest < ApplicationRecord
  has_many :game_sessions
end
