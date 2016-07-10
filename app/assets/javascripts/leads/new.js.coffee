$(document).on "ready page:load", ->
  app.leads.new.init() if $(".leads.new").length > 0

app.leads ||= {}
app.leads.new =
  init: ->
    @initMagnificPopup()
    @initPizzaButton()
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
  initPizzaButton: ->
    if $('.button-order').length > 0
      $(window).on 'scroll', (e) ->
        commandTop = $('.command-section').offset().top
        ctaTop = $('.button-order').offset().top
        if ctaTop > commandTop
          $('.button-order').hide()
      $('.button-order').on "click", ->
        $("html, body").animate {
          scrollTop: $(".command-section").offset().top
        }, 750
      right = ->
        $('.button-order > .cta').animate { left: '5px' }, 600, left
        return
      left = ->
        $('.button-order > .cta').animate { left: '-5px' }, 600, right
        return
      right()
