$(document).on "ready page:load", ->
  app.channels.new.init() if $(".buildings.show").length > 0

app.channels ||= {}
app.channels.new =
  init: ->
    @initForm()
    @hideChannelModalWhenNewMessageModal()
  initForm: ->
    $('#new_custom_channel').on "submit", ->
      if $('#channel_name').val().length == 0
        $('.channel_name').addClass('has-error')
        return false
      if $('#channel_users_id').val() == null && $('#channel_all_building:checked').length == 0
         $('.channel_users_id').addClass('has-error')
         return false
    $('form.edit_channel').on "submit", ->
      if $('.edit_channel #channel_users_id').val() == null
         $('.edit_channel .channel_users_id').addClass('has-error')
         return false
  hideChannelModalWhenNewMessageModal: ->
    $('#new-message_modal').on 'shown.bs.modal', ->
      $("#edit_channel_modal").modal("hide")
