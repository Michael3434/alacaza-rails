app.pages =
  home:
    init: ->
      @mixpanelTracking()
      $("body #scroll-down").click this.scrollHeroClicked
      $(".btn-cta").click this.scrollHeroClicked
      $('.p2').typed
        strings: [
          'entièrement sécurisée et privée'
        ]
        typeSpeed: 50
        backSpeed: 10
        backDelay: 2000
        showCursor: false
        loop: false

    scrollHeroClicked: ->
      $("html, body").animate {
        scrollTop: $(".cities").offset().top
      }, 750
    mixpanelTracking: ->
      $("#signin_modal").on "shown.bs.modal", ->
        mixpanel.track 'Affichage de l\'écran login'
      $("#signup_modal").on "shown.bs.modal", ->
        mixpanel.track 'Affichage de l\'écran signup'
      $("form.new_session").on "ajax:success", ->
        mixpanel.track 'Connexion'
      $("form#new_user").on "ajax:success", (e, data, status, xhr) ->
        mixpanel.track 'Inscription'
      mixpanel.track 'Page vue', 'Page': 'Home'

$(document).on "ready page:load", ->
  app.pages.home.init() if $(".static_pages.home").length > 0
