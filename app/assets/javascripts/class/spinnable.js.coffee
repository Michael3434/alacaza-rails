class @Spinnable
  constructor: (@el) ->

  init: ->
    @el.on 'ajax:beforeSend', @beforeSend
    @el.on 'ajax:success', @success
    @el.on 'ajax:error', @error

  beforeSend: (e, xhr, settings) ->
    $button = if $(this).is('form') then $(this).find('[type=submit]') else $(this)
    $button.addSpinner()

  success: (e, data, status, xhr) ->
    $button = if $(this).is('form') then $(this).find('[type=submit]') else $(this)
    $button.removeSpinner()

  error: ->
    $button = if $(this).is('form') then $(this).find('[type=submit]') else $(this)
    $button.removeSpinner()
