app.buildings ||= {}
app.buildings.show =
    init: ->
      @disableSubmitButton()
      @liveChat()
      @scrollOnloadPage()
      @logOnMixpanel()
      @showHideCommentForm()
    logOnMixpanel: ->
      mixpanel.track 'Page vue', 'Page': 'Messagerie'
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
    showHideCommentForm: ->
      $('.action-wrapper > .show-comment-form').on "click", ->
        commentForm = $(this).closest('.message-wrapper').find('.comment-form')
        commentForm.removeClass('hidden')
        commentForm.find('textarea').focus()
        $(this).addClass('hidden')
        $(this).closest('.action-wrapper').find('.hide-comment-form').removeClass('hidden')

      $('.action-wrapper > .hide-comment-form').on "click", ->
        $(this).closest('.message-wrapper').find('.comment-form').addClass('hidden')
        $(this).addClass('hidden')
        $(this).closest('.action-wrapper').find('.show-comment-form').removeClass('hidden')

$(document).on "ready page:load", ->
  app.buildings.show.init() if $(".admin.buildings.show").length > 0
