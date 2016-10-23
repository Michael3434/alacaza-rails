$(document).on "ready page:load", ->
  app.items.new.init() if $('.items.new, .items.create, items.edit').length > 0
app.items ||= {}
app.items.new =
  init: ->
    @initPhoto()
    @initForm()
    app.buildings.show.initSideBar()
  initPhoto: ->
    $('.photo-pending, #upload_image_preview').on "click", ->
      $('#item_photo').click()
    $('#item_photo').on "change", ->
      fileTypes = ['pdf']
      if this.files and this.files[0]
        reader = new FileReader
        name = this.files[0].name
        extension = name.split('.').pop().toLowerCase()
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
              $('#upload_image_preview').show()
              $('.photo-pending').hide()
            img.src = reader.result
          reader.readAsDataURL this.files[0]
  initForm: ->
    $('#new_item').on 'submit', ->
      FormIsValid = true
      if $('#item_category').val() == ""
        $('.item_category').addClass('has-error')
        FormIsValid = false
      if $('#item_price').val() == ""
        $('.item_price').addClass('has-error')
        FormIsValid = false
      if $('#item_title').val() == ""
        $('.item_title').addClass('has-error')
        FormIsValid = false
      if !$("#upload_image_preview").is(":visible")
        $('.photo-pending').css('border-color', 'red')
        FormIsValid = false
      if FormIsValid
        $('[type=submit]').attr('disabled', true)
      else
        return false
