window.app ||= {}

# Write here application wide javascript code
app.init = ->
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
  $("[data-spinnable=true]").each (i, el) ->
    spinnable = new Spinnable($(el))
    spinnable.init()
  $('.col-channels a').on "click", ->
    $('.scroll-container').css('opacity', "0")
    $('#loader').show()


$(document).on "ready page:load", ->
  app.init()
