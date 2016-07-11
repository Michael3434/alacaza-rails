$(document).on "ready page:load", ->
  app.leads.new.init() if $(".leads.new").length > 0

app.leads ||= {}
app.leads.new =
  init: ->
    @initMagnificPopup()
    mixpanel.track 'Page vue', 'Page': 'Commande'
  initMagnificPopup: ->
    $('.pizza-carousel').magnificPopup
      delegate: 'a'
      type: 'image'
      tLoading: 'Loading image #%curr%...'
      mainClass: 'mfp-img-mobile'
      gallery:
        enabled: true
        navigateByImgClick: true
        preload: [
          0
          1
        ]
      image:
        tError: '<a href="%url%">The image #%curr%</a> could not be loaded.'
        titleSrc: (item) ->
          item.el.attr('title') + '<small>by Marsel Van Oosten</small>'
