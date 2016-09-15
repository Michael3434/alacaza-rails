class Post < ActiveRecord::Base
  serialize :tags, Array
  belongs_to :user

  scope :published, -> { where(published: true) }

  TAG = ["Aides administratives",
    "Animations-loisir",
    "Animaux",
    "Beauté & Santé",
    "Bricolage",
    "Coaching",
    "Cours / Formations",
    "Covoiturage",
    "Déménagement",
    "Espaces vert / extérieurs",
    "Garde d'enfants",
    "Informatique",
    "Livraison / Réception",
    "Mécanique",
    "Musique",
    "Restauration",
    "Sécurité",
    "Soutien scolaire",
    "Sport",
    "Traduction / Interprète",
    "Transport",
    "Travaux ménagers",
    "Aides administratives",
    "Animations-loisir",
    "Animaux",
    "Beauté / Santé",
    "Bricolage",
    "Coaching",
    "Cours / Formations",
    "Covoiturage",
    "Déménagement",
    "Espaces vert / extérieurs",
    "Garde d'enfants",
    "Informatique",
    "Livraison / Réception",
    "Mécanique",
    "Musique",
    "Restauration",
    "Sécurité",
    "Soutien scolaire",
    "Sport",
    "Traduction / Interprète",
    "Transport",
    "Travaux ménagers"]

  with_options on: :publish do |space|
    space.validates :title, :description, :tags_are_present, presence: true
  end

  def tags_are_present
    if !tags.reject(&:empty?).compact.present?
      errors.add(:tags, "Au moins un domaine de compétence")
    else
      true
    end
  end
end
