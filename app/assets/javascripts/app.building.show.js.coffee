app.buildings ||= {}
app.buildings.show =
    init: ->
      @disableSubmitButton()
      @liveChat()
      @scrollOnloadPage()
    scrollOnloadPage: ->
      messageTop = $('.msg-container').last().offset().top
      $('html, .scroll-container').animate({scrollTop:messageTop}, 'slow');
    liveChat: ->
      window.client = new Faye.Client('/faye')
      client.subscribe '/messages', (payload) ->
          $('textarea').focus();
          $(".messages-container").append(payload.message) if payload.message
          messageTop = $('.msg-container').last().offset().top
          $('html, .scroll-container').animate({scrollTop:100000}, 'slow');
    disableSubmitButton: ->
      $('#new_message').submit ->
        if $('#message_body').val() == ""
          return false
        else
          $(this).find("button[type='submit']").prop('disabled', true)

$(document).on "ready page:load", ->
  app.buildings.show.init() if $(".admin.buildings.show").length > 0
