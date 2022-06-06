json.count_html json.partial!('game_sessions/guesses_count.html.erb', guesses_count: @guesses_ordered_by_latest.count)
json.list_html json.partial!('game_sessions/guesses.html.erb', guesses: @guesses_ordered_by_latest)
json.lyrics_html json.partial!('game_sessions/lyrics.html.erb', song: @game_session_song)
