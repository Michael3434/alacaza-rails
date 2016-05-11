window.app ||= {}

app.init = ->
  console.log "Init app.js"

  jQuery.each jQuery('.js-auto-size'), ->
    offset = @offsetHeight - (@clientHeight)

    resizeTextarea = (el) ->
      jQuery(el).css('height', 'auto').css 'height', Math.min(100, el.scrollHeight + offset)
      return

    jQuery(this).on('keyup input', ->
      resizeTextarea this
      return
    ).removeAttr 'data-autoresize'
    return

$(document).on "ready page:load", ->
  app.init()
