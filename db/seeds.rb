# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



puts "Creation du joueur"
@joueur = Guest.create!()

puts "Creation de la song"
lyrics = File.read("app/assets/paroles.txt")
@belle = Song.create!(lyrics: lyrics, author: "Céline Dion", title: "Pour que tu m'aimes encore")

puts "Creation du game mode"
@solo = Game.create!(name: "Chanson du jour")


puts "Creation de la game_song"
@song1 = GameSong.create!(game: @solo, song: @belle)

puts "Creation de la game_session"

@session = GameSession.create!(guest: @joueur, game: @solo)


puts "DONE"
