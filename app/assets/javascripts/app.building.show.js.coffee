app.buildings ||= {}
app.buildings.show =
    init: ->
      @liveChat()
      @scrollOnloadPage()
      @submitOnclickIcon()
    submitOnclickIcon: ->
      $('.fa-paper-plane').on 'click', ->
        if $('#message_body').val() != ""
          $(this).closest('form').submit()
    scrollOnloadPage: ->
      messageTop = $('.msg-container').last().offset().top
      $('html, body').animate({scrollTop:messageTop}, 'slow');
    liveChat: ->
      window.client = new Faye.Client('/faye')
      jQuery ->
        client.subscribe '/messages', (payload) ->
          $(".messages-container").append(payload.message) if payload.message
          messageTop = $('.msg-container').last().offset().top
          $('html, body').animate({scrollTop:messageTop}, 'slow');

$(document).on "ready page:load", ->
  app.buildings.show.init() if $(".admin.buildings.show").length > 0
