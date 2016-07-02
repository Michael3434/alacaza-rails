app.buildings ||= {}
app.buildings.show =
    init: ->
      @disableSubmitButton()
      @scrollOnloadPage()
      @logOnMixpanel()
      @initMessageGenerator()
      @initSideBar()
      @initNewMessageModal()
      @file()
    file: ->
      $('#message_photo').on "change", ->
        if this.files and this.files[0]
          reader = new FileReader
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
              Math.max(img.width)
              $('#upload_image_preview img').attr('src', e.target.result).width(width).height(height)
            img.src = reader.result
          reader.readAsDataURL this.files[0]
          $("#new-photo_modal").modal()

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
        $('.col-channels').hide("slide", { direction: "left" }, 200);
        $('.modal-bg').addClass('hidden')
    logOnMixpanel: ->
      mixpanel.track 'Page vue', 'Page': 'Messagerie'
    scrollOnloadPage: ->
      messageTop = $('.msg-container').last().offset()
      if messageTop != undefined
        $('html, .scroll-container').animate({scrollTop:messageTop.top}, 'slow');
    disableSubmitButton: ->
      $('#new_message').submit ->
        if $('#message_body').val() == ""
          return false
        else
          $(this).find("button[type='submit']").prop('disabled', true)
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
        buildingId = $(this).data('channel-id')

        $('#new-message_modal .member-image').attr("src", imgSrc)
        $('#new-message_modal .user-name').text(userName)
        $('#channel_recipient_id').val(userId)


$(document).on "ready page:load", ->
  app.buildings.show.init() if $(".admin.buildings.show").length > 0
