class Post < ActiveRecord::Base
  serialize :tags, Array
  belongs_to :user

  TAG = [
  "Transporteurs",
  "Bricoleurs",
  "Nettoyeurs",
  "Baby-sitter",
  "Geeks",
  "Musique",
  "Aide aux devoir",
  "Professeur",
  "Assistants"
]

  with_options on: :publish do |space|
    space.validates :title, :description, :tags, presence: true
  end

end
