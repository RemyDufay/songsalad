class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.string :lyrics
      t.string :author
      t.string :title
      t.string :genre
      t.integer :year

      t.timestamps
    end
  end
end
