$(document).on "ready page:load", ->
  app.channels.new.init() if $(".buildings.show").length > 0

app.channels ||= {}
app.channels.new =
  init: ->
    @initForm()
  initForm: ->
    $('form#new_custom_channel').on "submit", ->
      # ids = $('.selection [data-user-for-channel]').map((index,idContainer) ->
      #   $(idContainer).data('user-for-channel')
      # )
      # ids = $.unique(ids)
      # ids = $.makeArray( ids ).join(",")
      # $('#channel_users_id').val(ids)
