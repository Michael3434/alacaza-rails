$.fn.form_did_save = () ->
  $(".update-status").stop(true, true)
  $(".update-status span").hide()
  $(".update-status .success").show()
  $(".update-status").fadeOut(3000)

$.fn.form_did_not_save = () ->
  $(".update-status").stop(true, true)
  $(".update-status span").hide()
  $(".update-status .error").show()
  $(".update-status").fadeOut(3000)

$.fn.form_is_saving = () ->
  $(".update-status").stop(true, true);
  $(".update-status span").hide()
  $(".update-status .loading").show()
  $(".update-status").fadeIn()
