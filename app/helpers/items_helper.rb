module ItemsHelper
  def items_categories_collection
    ["Informatique & téléphonie",
    "Mode femme",
    "Mode homme",
    "Enfants & bébés",
    "Maison & jardin",
    "Auto moto",
    "Sport & jeux",
    "Films, livres & musique",
    "Immobilier",
    "Autre"].map { |item| [item, item] }
  end

  def time_ago_in_words_formated(timestamp)
    time = time_ago_in_words(timestamp)
    time.gsub!('minutes', 'm') if time.include?("minutes")
    time.gsub!('minute', 'm') if time.include?("minute")
    time.gsub!('heures', 'h') if time.include?("heures")
    time.gsub!('jours', 'j') if time.include?("jours")
    time.gsub!('moins d\'une minute', '< 1m') if time.include?("moins d\'une minute")
    time.gsub!(' ', '')
    return time
  end
end

