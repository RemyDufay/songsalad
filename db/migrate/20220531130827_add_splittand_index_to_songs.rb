class AddSplittandIndexToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :splitted_lyrics, :jsonb, default: []
    add_column :songs, :lyrics_index, :jsonb, default: {}
  end
end
