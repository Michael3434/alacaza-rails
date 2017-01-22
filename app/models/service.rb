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

  after_create :notify_users

  # This will notify all users who posted a mission who match the same category of the this service
  # It will also send an email to the service owner to inform him who need helps
  def notify_users
    Mission.where(category: self.category).each do |service|
      Mailer::UserMailerWorker.perform_in(3.seconds, :new_service_posted, service_id: self.id, user_id: service.user.id)
    end
    Mailer::UserMailerWorker.perform_in(3.seconds, :people_who_need_help, service_id: self.id)
  end

end
