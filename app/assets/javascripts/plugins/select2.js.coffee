if typeof($.fn.select2) != "undefined"
  $.fn.select2.defaults.set("theme","bootstrap")
  $(document).on "ready page:load", ->
    $(".js-multiple-select").select2({
      placeholder: "Ajoutez votre liste d'immeuble à notifier"
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
