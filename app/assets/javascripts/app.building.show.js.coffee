app.buildings ||= {}
app.buildings.show =
    init: ->
      @scrollOnloadPage()
      @submitOnclickIcon()
    submitOnclickIcon: ->
      $('.fa-paper-plane').on 'click', ->
        if $('#message_body').val() != ""
          $(this).closest('form').submit()
    scrollOnloadPage: ->
      messageTop = $('.msg-container').last().offset().top
      $('html, body').animate({scrollTop:messageTop}, 'slow');

$(document).on "ready page:load", ->
  app.buildings.show.init() if $(".admin.buildings.show").length > 0
