window.app ||= {}

# Write here application wide javascript code
app.init = ->
  if $('.admin').length > 0
    $('form').attr('remote', 'true').each (i, el) ->
      obj = new Huddable($(el))
      obj.init()
  $.each $('.js-auto-size'), ->
    offset = @offsetHeight - (@clientHeight)
    resizeTextarea = (el) ->
      if el.scrollHeight == 40
        return
      else if $(el).val().length == 0
        $(el).css('height', '42px')
        $('.scroll-container').css 'bottom', '48px'
        return
      $(el).css('height', 'auto').css 'height', Math.min(100, el.scrollHeight + offset)
      $('.scroll-container').css 'bottom', Math.min(100, el.scrollHeight + offset)
    $(this).on('keyup input', ->
      resizeTextarea this
    ).removeAttr 'data-autoresize'

  $('[data-toggle="tooltip"]').tooltip()

  $("[data-spinnable=true]").each (i, el) ->
    spinnable = new Spinnable($(el))
    spinnable.init()

  $('.group-channels .list, .private-channels a').on "click", ->
    $('.scroll-container').css('opacity', "0")
    $('#loader').show()
    if $( window ).width() <= 766
      $('.col-channels').hide()
      $('.modal-bg').hide()

  $("[data-autosubmit=true]").on "change", ->
    $(this).submit()
  $(document).on "change", "[data-behavior=autosubmit]", ->
    $(this).submit()


$(document).on "ready page:load", ->
  app.init()
