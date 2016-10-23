$(document).on "ready page:load", ->
  app.users.items.show.init() if $(".items.show").length > 0

app.users ||= {}
app.users.items ||= {}
app.users.items.show =
  init: ->
    app.buildings.show.initSideBar()
