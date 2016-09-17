$(document).on "ready page:load", ->
  app.votes.new.init() if $(".buildings.show").length > 0

app.votes ||= {}
app.votes.new =
  init: ->
    @initCalendar()
    @showHideForm()
    @addDateToForm()
  initCalendar: ->
    $('.calendar').datepicker(
        multidate: 5
        startDate: convertDate(new Date())
        language: 'fr'
      ).on 'changeDate', (ev) ->
        $('.date-wrapper').empty()
        $.each $(".calendar").datepicker('getDates'), (index,date) ->
          day = date.getDate()
          month = date.getMonth()
          year = date.getFullYear()
          options = {weekday: "long", year: "numeric", month: "long", day: "numeric"};
          date = new Date(Date.UTC(year, month, day, 3, 0, 0));
          date = date.toLocaleDateString("fr-FR", options)
          $('.date-wrapper').append('<div class="space-2 space-top-2 date-text">' + date + '</div>')
  showHideForm: ->
    $('.toogle-event').on "click", ->
      $('.event-wrapper').show()
      $('.survey-wrapper').hide()
      return false
    $('.toogle-survey').on "click", ->
      $('.survey-wrapper').show()
      $('.event-wrapper').hide()
      return false
  addDateToForm: ->
    if $('.survey-event').is(":visible")
      $('#votes_modal .new_message').on 'submit', ->
        $.each $('.date-wrapper .date-text'), (index, el) ->
          $('#message_option_' + (index + 1)).val($(el).text())

