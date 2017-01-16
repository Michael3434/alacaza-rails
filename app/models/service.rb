class Service < ActiveRecord::Base
  belongs_to :user

  CATEGORY = {
    "Service à domicile" =>
      ["Babysitting et nounous",
      "Cours particuliers et coaching",
      "Nettoyage, repassage et cuisine",
      "Animaux",
      "Réparations et dépannage",
      "Bricolage et jardinage"],
    "Service véhiculé" =>
      ["Courses et livraison",
      "Déménagement",
      "Transport, co-voiturage"],
    "Préstation freelance" =>
      ["Prestations web, design, photo",
      "Mode, beauté et bien-être",
      "Prestations administratives"],
    "Conseils et activités" =>
      ["Informations et conseils",
      "Sports, loisirs et événements"],
    "Les objets de mes voisins" =>
      ["Recherche d'objets d'occasion",
      "Emprunt et location d'objets"],
    "Autre" =>
      ["Immobiler (achat, location et co-location)",
      "Recrutements et stages",
      "Autre"],
  }

  validates :title, :category, :description, presence: true

end
