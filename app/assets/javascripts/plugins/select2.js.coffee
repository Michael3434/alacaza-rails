if typeof($.fn.select2) != "undefined"
  $.fn.select2.defaults.set("theme","bootstrap")
  $(document).on "ready page:load", ->
    $(".js-multiple-select").select2({
      placeholder: "Ajoutez votre liste d'immeuble à notifier"
    })
    $(".js-multiple-select-tags").select2({
      placeholder: "2 tags maximum"
      maximumSelectionLength: 2
      formatSelectionTooBig: (limit) ->
        '2 tags maximum'
    })
    $(".js-multiple-select-user").select2({
      placeholder: "Selectionnez un user"
      maximumSelectionLength: 1
    })
    $(".js-multiple-select-users").select2({
      placeholder: "Ajoutez à votre liste des résidents"
      })
    $(".js-example-basic-single").select2({
      minimumResultsForSearch: Infinity,
      placeholder: "Choisissez votre immeuble"
    })
    $(".js-district-basic-single").select2({
      minimumResultsForSearch: Infinity,
      placeholder: "Choisissez le quartier"
    })
    $(".js-sex-basic-single").select2({
      minimumResultsForSearch: Infinity,
      placeholder: "Choisissez votre sexe"
    })
    $(".js-user-status-basic-single").select2({
      minimumResultsForSearch: Infinity,
      placeholder: "Êtes-vous locataire/copropriétaire ?"
    })
    $(".js-single-value-select-building").select2
      maximumSelectionLength: 1
    $(".js-multiple-select-users").select2
      placeholder: "Cherche par nom"
