class Post < ActiveRecord::Base
  serialize :tags, Array
  belongs_to :user

  scope :published, -> { where(published: true) }

  TAG = [
  "Transporteurs",
  "Bricoleurs",
  "Nettoyeurs",
  "Baby-sitter",
  "Geeks",
  "Musique",
  "Aide aux devoir",
  "Professeur",
  "Informatique",
  "Assistants"
]

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
