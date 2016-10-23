module ItemsHelper
  def categories_collection
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
end
