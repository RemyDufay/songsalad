require 'nokogiri'
require 'open-uri'

class GameSessionsController < ApplicationController

  def create
    @game_session = GameSession.new(game_session_params)
  end

  def show
    @game_session = GameSession.find(params[:id])

    # Récupération des paroles
    htmlyrics = @game_session.songs[0].lyrics

    # Transformation des paroles en module Nokogiri, qui permettra par la suite
    # de naviguer dans les balises html et censurer les mots (sans perdre le balisage)
    @html = Nokogiri::HTML.fragment($htmlyrics)

    # On stocke le titre (la premier balise div) dans un coin pour vérifier la condition de victoire
    @title = @game_session.songs[0].title

    # Création d'un array avec tous les mots de la chanson, qui permet ensuite de
    # lancer un .count et récupérer la fréquence d'un mot dans la chanson
    @arrayofwords = htmlyrics.split(/([a-zA-Z\u00C0-\u00FF]+|\s|\W|\w\W\w)/).map!(&:downcase).reject!(&:empty?)

    # A chaque chargement de la page, on génére les paroles censurées :
    @htmlredact = htmlredact()

    # On vérifie si il ya un mot soumis par le formulaire
    # Si oui on crée un Guess avec, et on redirect vers le show pour "nettoyer" l'url du param
    # Peut sans doute etre amélioré en ne mettant pas le résultat du form dans l'url ?
    # Ce qui éviterait une redirection inutile.
    if params[:query].present?
      word = params[:query].downcase.strip
      frequency  = @arrayofwords.count(word)
      Guess.create!(game_session: @game_session, word: word, frequency: frequency)
      redirect_to game_session_path(@game_session)
    end

    # Condition de victoire : si le texte ne censure plus le titre, c'est gagné.
    if @htmlredact.include? @title
      flash[:notice] = "✨Bravo !✨"
    end
  end

  def all
    @all = game_session.all.where(guest_id)
  end


private

# Récupere le fichier html et, pour chaque div, lance la censure
# C'est Nokogiri qui fait le job de visiter chaque div.
# Pourquoi ne pas itérer et renvoyer du texte ? Parce qu'on veut garder
# les balises html pour la mise en forme !
  def htmlredact
    htmlredacted = @html.css("div").each do |node|
      node.content = stringredact(node.content)
    end
    return htmlredacted.to_html
  end

# Divise une string en mots/ponctuaction/espaces et applique redact() sur chaque élément non proposé par l'utilisateur
# C'est le moteur du jeu : Celui qui décide ce qui est caché ou non.
# La regex permet de séparer mots, ponctuation, etc.. et garde les mots
# à cédille, comme "aujourd'hui", en entiers
  def stringredact(string)
    redacted = string.split(/(\w{3,}'\w{3,}|[a-zA-Z\u00C0-\u00FF]+|\s|\W|\w\W\w)/).reject!(&:empty?).map do |word|
      if Guess.where(game_session: @game_session).where(word: word.downcase).empty?
        redact(word)
      else
        word
      end
    end
    redacted.join('')
  end

# Remplace chaque lettre d'un mot par un bloc. Uniquement si il s'agit d'alphanumérique
  def redact(word)
    redacted = ""
      word.each_char do |char|
        (char =~ /[[:alpha:]]/) ?  redacted += "█" :  redacted += char
      end
    return redacted
  end

  def game_session_params
    params.require(:game_session).permit(:guest_id, :game_id, :victory?)
  end

end
