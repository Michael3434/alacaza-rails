module MessagesHelper
  def user_image(message)

  end

  def generate_button
    [
      ["Coupure d'eau", "coupure-d-eau"],
      ["Coupure d'électricité", "coupure-d-electricite"],
      ["Poubelle", "poubelle"],
      ["Chauffage", "chauffage"],
      ["Panne d’ascenseur", "panne-ascenseur"],
      ["Événement", "evenement"]
    ]
  end

  def user_img(img_id)
    "icons/icon" + img_id.to_s + ".png"
  end
end
