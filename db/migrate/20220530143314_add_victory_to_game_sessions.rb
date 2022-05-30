class AddVictoryToGameSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :game_sessions, :victory?, :boolean
  end
end
