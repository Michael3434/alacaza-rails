window.app ||= {}

app.init = ->
  console.log "Init app.js"

  $.each $('.js-auto-size'), ->
    offset = @offsetHeight - (@clientHeight)

    resizeTextarea = (el) ->
      $(el).css('height', 'auto').css 'height', Math.min(100, el.scrollHeight + offset)
      return

    $(this).on('keyup input', ->
      resizeTextarea this
      return
    ).removeAttr 'data-autoresize'
    return

$(document).on "ready page:load", ->
  app.init()
