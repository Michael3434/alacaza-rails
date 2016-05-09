app.buildings ||= {}
app.buildings.show =
    init: ->
      @submitOnclickIcon()
    submitOnclickIcon: ->
      $('.fa-paper-plane').on 'click', ->
        $(this).closest('form').submit()

$(document).on "ready page:load", ->
  app.buildings.show.init() if $(".admin.buildings.show").length > 0
