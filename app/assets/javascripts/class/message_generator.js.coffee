class @MessageGenerator
  generate: (value) ->
    switch value
      when "coupure-d-electricite"
        "Chers résidents, nous vous annonçons une coupure d'éléctricité générale le XX/XX/XX de XXh à XXh.
        Votre gardienne, Anabel."
      when "coupure-d-eau"
        "Chers résidents, nous vous annonçons une coupure d'eau générale le XX/XX/XX de XXh à XXh.
        Votre gardienne, Anabel."
      when "magic-action"
        "Whaouuu, magique non ? La team alacaza te souhaite une agréable journée ! "
      when "poubelle"
        "Chers résidents du 12, rue Jean Richepin, nous vous rappelons que les poubelles passeront demain à XX.
        Nous vous remercions pour votre coopération. Votre gardienne, Anabel."
      when "chauffage"
        "Chers résidents, nous vous informons que le chauffage sera réactivé / sera coupé à partir du XX/XX/XX.
        Votre gardienne, Anabel "
      when "panne-ascenseur"
        "Chers résidents, nous vous informons que l’ascenseur est en panne jusqu’au XX/XX/XX.
        Votre gardienne, Anabel."
      when "evenement"
        "Chers résidents, vous êtes conviés à l’évènement XX qui aura lieu le XX/XX/XX.
       Nous espérons avoir le plaisir de vous y retrouver. Votre gardienne, Anabel."

