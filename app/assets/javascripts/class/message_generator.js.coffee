class @MessageGenerator
  generate: (value) ->
    switch value
      when "plombier"
        "Generatation plombier message"
      when "coupure-d-eau"
        "Chers résidents, suite à un dégât des eaux, nous vous
        annonçons une coupure d'eau générale demain matin entre 8h et 12h.
        Votre gardienne, Annabelle."
