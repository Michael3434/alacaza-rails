if typeof($.fn.select2) != "undefined"
  $.fn.select2.defaults.set("theme","bootstrap")
  $(document).on "ready page:load", ->
    $(".js-multiple-select").select2()
    $(".js-example-basic-single").select2({
      minimumResultsForSearch: Infinity,
      placeholder: "Choisissez votre immeuble"
      })
