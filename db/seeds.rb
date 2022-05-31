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

dernieredansel =  File.read("app/assets/lyrics/dernieredanse.txt")
@dernieredanse = Song.create!(lyrics: dernieredansel, author: "Kyo", title: "Dernière danse", genre: 'pop', year: 2003)

letempsestbonl =  File.read("app/assets/lyrics/letempsestbon.txt")
@letempsestbon = Song.create!(lyrics: letempsestbonl, author: "A bon entendeur", genre:'electro', year: 2019)

toutoublierl = File.read("app/assets/lyrics/toutoublier.txt")
@toutoublier = Song.create!(lyrics: toutoublierl, author: "Angele",  title:"Tout oublier", genre: 'pop', year: 2018)

lesyeuxdisentl = File.read("app/assets/lyrics/lesyeuxdisent.txt")
@lesyeuxdisent = Song.create!(lyrics: lesyeuxdisentl, author: "Lomepal", title: "Les yeux disent", genre: 'electro', year: 2017)

dommagel =  File.read("app/assets/lyrics/dommage.txt")
@dommage = Song.create!(lyrics: dommagel, author: "Bigflo et Oli",title: "Dommage", genre:'rap', year: 2017)


tamarinierel =  File.read("app/assets/lyrics/tamariniere.txt")
@tamariniere = Song.create!(lyrics: tamarinierel, author: "Hoshi",title: "Ta marinière", genre:'electro', year: 2019)

auvergnatl  =  File.read("app/assets/lyrics/auvergnat.txt")
@auvergnat = Song.create!(lyrics: auvergnatl, author: "Brassens",title: "Auvergnat", genre: 'classique', year: 1965 )

dal =  File.read("app/assets/lyrics/da.txt")
@da = Song.create!(lyrics: dal, author: "PNL",title: "Da", genre:'rap', year: 2016)

odeurdessencel =  File.read("app/assets/lyrics/odeurdessence.txt")
@odeurdessence = Song.create!(lyrics: odeurdessencel, author: "Orelsan",title: "L’Odeur de l’essence", genre:'rap', year: 2021)


maisjetaime =  File.read("app/assets/lyrics/maisjetaime.txt")
@jetaime = Song.create!(lyrics: maisjetaime, author: "Grand corps malade",title: "Mais je t’aime" , genre:'moderne', year: 2016)

djadjal =  File.read("app/assets/lyrics/djadja.txt")
@djadja = Song.create!(lyrics: djadjal, author: "Aya Nakamura",title: "Djadja", genre:'rap', year: 2018)

jour1 =  File.read("app/assets/lyrics/jour.txt")
@jour = Song.create!(lyrics: jour1, author: "Louane",title: " Jour 1" , genre:'moderne', year: 2015)


papaoutel =  File.read("app/assets/lyrics/papaoutai.txt")
@papaouta = Song.create!(lyrics: papaoutel, author: "Stromae",title: "Papaoutai", genre:'electro', year: 2013)


douvlel =  File.read("app/assets/lyrics/doubleje.txt")
@double = Song.create!(lyrics: douvlel, author: "Christophe  Willem",title: "Double je", genre:'electro', year: 2007)


jeuneeconl =  File.read("app/assets/lyrics/jeuneetcon.txt")
@jeune = Song.create!(lyrics: jeuneeconl, author: "Saez",title: "Jeune et con", genre:'rock', year: 2007)

roidumondel =  File.read("app/assets/lyrics/lesroisdumonde.txt")
@roidumonde =  Song.create!(lyrics: roidumondel, author: "Romeo et Juliette",title: "Les Rois du monde", genre:'comédie musicale', year: 2007)

confessionnocturnel =  File.read("app/assets/lyrics/confessionnocturne.txt")
@confessionnocturne = Song.create!(lyrics: confessionnocturnel, author: "Diams Vitaa",title: "Confession nocturne", genre:'rap', year: 2006)

caravanel =  File.read("app/assets/lyrics/caravane.txt")
@caravane = Song.create!(lyrics: caravanel, author: "Raphael",title: "Caravane", genre:'moderne', year: 2005)


pholosophiel =  File.read("app/assets/lyrics/maphilosophie.txt")
@philosophie = Song.create!(lyrics: pholosophiel, author: "Amel Bent",title: " Ma Philosophie", genre:'populaire', year: 2004)

parcequonvientdeloin =  File.read("app/assets/lyrics/parcequonvientdeloin.txt")
@parcequonvientde = Song.create!(lyrics: parcequonvientdeloin, author: "Corneille",title: "Parce qu'on vient de loin", genre:'moderne', year:   2002)



quelqunmadil =  File.read("app/assets/lyrics/quelqunmadit.txt")
@quelqunmadit = Song.create!(lyrics: quelqunmadil, author: "Carla Bruni",title: "Quelq’un m’a dit", genre:'moderne', year:  2002)


tameilleureamii =  File.read("app/assets/lyrics/meilleureamie.txt")
@tameilleurami = Song.create!(lyrics: tameilleureamii, author: "Lorie",title: "je serai ta meilleure amie", genre:'pop', year: 2001)


lotital =  File.read("app/assets/lyrics/lolita.txt")
@lolita = Song.create!(lyrics: lotital, author: "Alysée",title: "lolita", genre:'pop', year: 2000)


mousse =  File.read("app/assets/lyrics/petitbonhomme.txt")
@petibonhommenmousse = Song.create!(lyrics: mousse, author: "Patrick Sebastien", title: "Le petit bonhomme en mousse", genre:'populaire', year: 1999)


alumerlefeu =  File.read("app/assets/lyrics/allumerlefeu.txt")
@allumerlefe = Song.create!(lyrics: alumerlefeu, author: "Johnny", title: "Allumer le feu", genre:'rock', year: 1998)

tribudedana =  File.read("app/assets/lyrics/dana.txt")
@latrubudedana = Song.create!(lyrics: tribudedana, author: "Manau", title: "la trubu de Dana", genre: 'folk', year: 1998)


tomberlachemise =  File.read("app/assets/lyrics/chemise.txt")
@tomblachemise = Song.create!(lyrics: tomberlachemise, author: "Zebda", title: "Tomber la chemise ", genre: 'populaire', year: 1998)


hymne =  File.read("app/assets/lyrics/campagne.txt")
@hymdenocampag = Song.create!(lyrics: hymne, author: "Tryo", title: " Hymne de nos campagnes", genre: 'folk', year:  1998)

jtemenneauvent =  File.read("app/assets/lyrics/vent.txt")
@vienjtemenauven = Song.create!(lyrics: jtemenneauvent, author: "Louise Attaque",title: "Allez viens j’t'emmène au vent", genre: 'folk', year: 1997)

hommepres =  File.read("app/assets/lyrics/hommepressé.txt")
@hommepresse = Song.create!(lyrics: hommepres, author: "Noir Désir",title:"Homme Pressé", genre: 'rock', year: 1996)


miaa =  File.read("app/assets/lyrics/mia.txt")
@mia = Song.create!(lyrics: miaa, author: "IAM",title: "Je danse le mia", genre: 'rap', year: 1993)

foule =  File.read("app/assets/lyrics/foulesentimentale.txt")
@sentimentale = Song.create!(lyrics: foule, author: "Souchon",title: "Foule sentimentale", genre: 'moderne', year: 1993)

hissezhaut =  File.read("app/assets/lyrics/santiano.txt")
@santiano = Song.create!(lyrics: hissezhaut, author: "Aufray",title: "Santiano", genre: 'folk', year: 1990)




dal =  File.read("app/assets/lyrics/__.txt")
@da = Song.create!(lyrics: --, author: "--",title: "--", genre: '__', year: --)



puts "Creation du game mode"
@solo = Game.create!(name: "Chanson du jour")


puts "Creation de la game_song"
@song1 = GameSong.create!(game: @solo, song: @belle)

puts "Creation de la game_session"

@session = GameSession.create!(guest: @joueur, game: @solo)


puts "DONE"
