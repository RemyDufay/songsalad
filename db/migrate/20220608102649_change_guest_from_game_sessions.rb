class ChangeGuestFromGameSessions < ActiveRecord::Migration[6.1]
  def change
    change_column_null :game_sessions, :guest_id, true
  end
end
