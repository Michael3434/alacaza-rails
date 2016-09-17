window.convertDate = (date) ->
  pad = (s) ->
    if s < 10 then '0' + s else s

  [
    pad(date.getDate())
    pad(date.getMonth() + 1)
    date.getFullYear()
  ].join '/'

window.concatDate = (day, month, year) ->
  pad = (s) ->
    if s < 10 then '0' + s else s

  [
    pad(day)
    pad(month)
    pad(year)
  ].join '/'

# Returns a date object from a fr formatted string
#  Ex : @string = "31/12/2015"
window.parseDate = (string) ->
  dates = string.split('/')
  d = dates[0]
  m = dates[1]
  y = dates[2]
  new Date([
    m
    d
    y
  ].join('/'))

# Take an array of dates as string and returns a readable version
# Ex: [14/07/2015, 15/07/2015, 16/07/2015] => 14/07/2015, 15/07/2015 et 16/07/2015
window.datesToText = (dates) ->
  length = dates.length
  if length == 1
    dates[0]
  else if length > 1
    [..., last] = dates
    dates[0..-2].join(", ") + " et #{last}"

window.dateDaysFromNow = (numberOfDaysFromNow) ->
  new Date(new Date().getTime() + numberOfDaysFromNow * (24 * 60 * 60 * 1000))
