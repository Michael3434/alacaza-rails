app.buildings ||= {}
app.buildings.show =
    init: ->
      @disableSubmitButton()
      @scrollOnloadPage()
      @initMessageGenerator()
      @initSideBar()
      @initNewMessageModal()
      @initFile()
      @removeImgOnHideModal()
      # @showReactionOnOverMessage() // Disable like
      @showReactionOnOverMessage()
      @initCarousel()
      @showHomeIconBadge()
      @initUserPhoto()
      @disabledOnSubmitPostMessage()
      @unsubscribeFromChannel()
    unsubscribeFromChannel: ->
      channelId = $('.client-ui').data('unsubscribe')
      if channelId
        $('#notification_modal input[data-channel-id=' + channelId + ']').click()
        alert("Désinscription aux notifications pour ce canal de discussion réussie. \nSi toutefois vous souhaitez réactiver les notifications, rendez-vous sur le menu de gauche dans la section 'Mes notifications'")
    disabledOnSubmitPostMessage: ->
      $('form#new_post_message').on 'submit', ->
        $(this).find('btn').attr('disabled', 'true')
        $(this).css('opacity', '0.3')
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


    showHomeIconBadge: ->
      if $(".badge.candy_red_bg").length > 0
        $('.badge-home.candy_red_bg').removeClass("hidden")
      else if $(".candy_yellow_bg").length > 0
        $('.badge-home.candy_yellow_bg').removeClass("hidden")

    initCarousel: ->
      $("[class*='picture-wrapper-']").each ->
        $(this).magnificPopup
          delegate: 'a'
          type: 'image'
          gallery:
            enabled: true
            navigateByImgClick: true
            preload: [
              0
              1
            ]
    showReactionOnOverMessage: ->
      $('.message-content').mouseenter ->
        $(this).find('.reaction-container').show()
      $('.message-content').mouseleave ->
        $(this).find('.reaction-container').hide()
    removeImgOnHideModal: ->
      $("#new-photo_modal").on "hide.bs.modal", ->
        $('#upload_image_preview img').attr('src', "").attr("style", "")
    initFile: ->
      $('#message_photo').on "change", ->
        fileTypes = ['pdf']
        if this.files and this.files[0]
          reader = new FileReader
          name = this.files[0].name
          extension = name.split('.').pop().toLowerCase()
          $('#upload_image_preview .title').html(name)
          if fileTypes.indexOf(extension) > -1
          else
            reader.onload = (e) ->
              img = new Image
              img.onload = ->
                if img.width > img.height
                  height = 150
                  width = height * img.width / img.height
                else if img.width < img.height
                  height = 150
                  width = height * img.width / img.height
                else
                  width = 150
                  height = 150
                $('#upload_image_preview img').attr('src', e.target.result).width(width).height(height)
              img.src = reader.result
            reader.readAsDataURL this.files[0]
          $("#new-photo_modal").modal()
          $("#body-from-file").val($('#message_body').val())
          $('#message_body').val("")

      $('.new-photo').on "click", ->
        formData = new FormData
        $input = $('#message_photo')
        $('#message_body').val($("#body-from-file").val())
        formData.append 'message[photo]', $input[0].files[0]
        $('form#new_message').serializeArray().forEach (field) ->
          formData.append field.name, field.value
        $('#message_body').val("")
        $.ajax
          url: "/messages"
          data: formData
          cache: false
          contentType: false
          processData: false
          type: 'POST'
          beforeSend: (xhr) ->
            $("#new-photo_modal").modal('hide')
            $('.navbar-progress').show()
            elem = $('.progress_bar_progress_thin')[0]
            width = 1
            frame = ->
              width++
              elem.style.width = width + '%'
            id = setInterval(frame, 100)
    initSideBar: ->
      $('.info-icon').on "click", (e) ->
        e.preventDefault()
        $('.col-channels').show("slide", { direction: "left" }, 200);
        $('.modal-bg').hide().removeClass('hidden').fadeIn().show()
      $('.modal-bg').on "click", (e) ->
        $('.col-channels').hide("slide", { direction: "left" }, 200)
        $('.modal-bg').addClass('hidden')
    scrollOnloadPage: ->
      messageTop = $('.msg-container').last().offset()
      if messageTop != undefined
        $('html, .scroll-container').animate({scrollTop:99999999}, 'slow');
    disableSubmitButton: ->
      $('form#new_message').on "submit", ->
        if $('#message_body').val() == ""
          return false
        else
          button = $(this).find("button[type='submit']")
          button.prop('disabled', true)
          button.removeClass('ion-paper-airplane').addClass('ion-loading-c')
    initMessageGenerator: ->
      $('.btn-generator').on "click", ->
        obj = new MessageGenerator
        id = $(this).data('generatorId')
        message = obj.generate(id)
        $('#message_body').val(message)
    initNewMessageModal: ->
      $('.message-sender').on "click", ->
        userId = $(this).data('user-id')
        userName = $(this).data('user-name')
        imgSrc = $('.icon-user-' + userId).first().find('img').attr('src')

        $('#new-message_modal .member-image').attr("src", imgSrc)
        $('#new-message_modal .user-name').text(userName)
        $('#channel_recipient_id').val(userId)

$(document).on "ready page:load", ->
  app.buildings.show.init() if $(".buildings.show").length > 0
