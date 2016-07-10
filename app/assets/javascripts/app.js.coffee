window.app ||= {}

# Write here application wide javascript code
app.init = ->
  console.log "Init app.js"

  $(window).on 'scroll', (e) ->
    commandTop = $('.command-section').offset().top
    ctaTop = $('.button-order').offset().top
    if ctaTop > commandTop
      $('.button-order').hide()
  $('.button-order').on "click", ->
    $("html, body").animate {
      scrollTop: $(".command-section").offset().top
    }, 750
  right = ->
    $('.button-order > .cta').animate { left: '5px' }, 600, left
    return
  left = ->
    $('.button-order > .cta').animate { left: '-5px' }, 600, right
    return
  right()

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


$(document).on "ready page:load", ->
  app.init()
