$.fn.addSpinner = (position) ->
  # Build spinner span
  span = $('<span></span>', class: "spinner #{position}")
  i = $('<i></i>', class: 'ion-loading-c')
  if $(this).hasClass('btn-lg') then i.addClass('fa-lg') else ''
  # Attach to target
  i.appendTo span
  span.appendTo $(this)
  # Disable button or link
  if $(this).is('a, button')
    $(this).attr 'disabled', true
  else if $(this).is('div')
    $(this).find('input').attr 'disabled', 'disabled'

$.fn.removeSpinner = ->
  # Remove spinner span
  $(this).find('.spinner').remove()
  # Re-enable buttons or links
  if $(this).is('a, button')
    $(this).attr 'disabled', false
  else if $(this).is('div')
    $(this).find('input').attr 'disabled', false
