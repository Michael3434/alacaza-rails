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

  def already_voted?(message, option_id)
    message.send("vote_for_#{option_id}").include?(current_user.id)
  end
end
