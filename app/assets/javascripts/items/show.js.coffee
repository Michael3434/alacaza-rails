$(document).on "ready page:load", ->
  app.users.items.show.init() if $(".items.show").length > 0

app.users ||= {}
app.users.items ||= {}
app.users.items.show =
  init: ->
    @initCarousel()
  initCarousel: ->
    $(".js-carousel").each ->
      $(this).magnificPopup
        delegate: 'a'
        type: 'image'
        gallery:
          enabled: true
          navigateByImgClick: true
          preload: [
            0
            1
          ]
