$(document).on "ready page:load", ->
  app.users.users.account.init() if $(".users.account").length > 0

app.users ||= {}
app.users.users ||= {}
app.users.users.account =
    init: ->
      @initUserPhoto()
    initUserPhoto: ->
      $('.image-wrapper').on "mouseenter", ->
        $(".hover-background").show()
      $('.image-wrapper').on "mouseleave", ->
        $(".hover-background").hide()
      $('.hover-background').on "click", ->
        $('#user_photo').click()

      $('.submit-tick').on "click", ->
        $('form#edit_user_fields').submit()

      $('#user_photo').on "change", ->
        formData = new FormData
        $input = $('#user_photo')
        userId = $('#edit_profil_modal .modal-content').data('user-id')
        formData.append 'user[photo]', $input[0].files[0]
        $('form.edit_user').serializeArray().forEach (field) ->
          formData.append field.name, field.value
        $.ajax
          url: "/users/" + userId + "/change_picture"
          data: formData
          cache: false
          contentType: false
          processData: false
          type: 'POST'
          beforeSend: (xhr) ->
            i = $('<i></i>', class: 'fa fa-spinner fa-spin').css('font-size', "27px")
            $('.fa-camera').remove()
            $(".hover-background").show().prepend(i)
            $('.hover-background .text-center').html("Téléchargement...")
