$(document).on "ready page:load", ->
  app.users.items.index.init() if $(".items.index").length > 0

app.users ||= {}
app.users.items ||= {}
app.users.items.index =
  init: ->
    app.buildings.show.initSideBar()
