class @Huddable
  constructor: (@el) ->

  init: ->
    @el.on "ajax:beforeSend", @beforeSend
    if @el.data("type") == "json"
      @el.on "ajax:success", @success

    @el.on "ajax:error", @error

  beforeSend: (e, xhr, settings) ->
    $(this).form_is_saving()

  success: (e, data, status, xhr) ->
    if data.errors
      alert "Vos changements n'ont pas été enregistrés"
      if $(this).data("model-name")
        $(this).render_form_errors($(this).data("model-name"), xhr.responseJSON.errors)
      $(this).form_did_not_save()
    else
      $(this).clear_form_errors()
      $(this).form_did_save()

  error: (e, xhr, status, error) ->
    $(this).form_did_not_save()
    if error == "Internal Server Error"
      error = "Une erreur est survenue lors de l'enregistrement."
    alert(error)
