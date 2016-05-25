class @MessageGenerator
  generate: (value) ->
    switch value
      when "coupure-d-electricite"
        "Chers résidents, suite à un dégât des eaux, nous vous annonçons une coupure d'eau générale le XX/XX/XX de XXh à XXh.
        Votre gardienne, Annabelle."
      when "coupure-d-eau"
        "Chers résidents, suite à un dégât des eaux, nous vous annonçons une coupure d'eau générale le XX/XX/XX de XXh à XXh.
        Votre gardienne, Annabelle."
      when "magic-action"
        "Whaouuu, magique non ? La team alacaza te souhaite une agréable journée ! "
      when "poubelle"
        "Chers résidents du 12, rue Jean Richepin, nous vous rappelons que les poubelles passeront demain à XX.
        Nous vous remercions pour votre coopération. Votre gardienne, Annabelle."
      when "chauffage"
        "Chers résidents, nous vous informons que le chauffage sera réactivé / sera coupé à partir du XX/XX/XX.
        Nous vous prions de nous excuser pour la gêne occasionnée. Votre gardienne, Annabelle "
      when "panne-ascenseur"
        "Chers résidents, nous vous informons que l’ascenseur est en panne jusqu’au XX/XX/XX.
        Votre gardienne, Annabelle."
      when "evenement"
        "Chers résidents, vous êtes conviés à l’évènement XX qui aura lieu le XX/XX/XX.
       Nous espérons avoir le plaisir de vous y retrouver. Votre gardienne, Annabelle."

