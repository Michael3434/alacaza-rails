$(document).on "ready page:load", ->
  app.infinitScroll.init() if $(".buildings.show").length > 0

app.infinitScroll =
  init: ->
    $('.scroll-container').scroll ->
      messageTop = $('.message-wrapper').first().offset().top
      if messageTop > 53 && !$('#messages-loader').is(":visible") && $('#messages-loader').data('continue') == true
        $('#messages-loader').show()
        url = $('#next-page').data('url')
        page = $('#next-page').data('next-page')
        $.ajax
          url: url
          data: { page: page }
          type: 'get'
          dataType : 'script'
          beforeSend: (settings, xhr) ->


