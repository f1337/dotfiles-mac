# Get calendar events on your desktop with cute bullets
# Originally by Cara Takemoto
# Using icalBuddy: http://hasseg.org/icalBuddy/
# Updated icalBuddy with Catalina support from: https://github.com/DavidKaluta/icalBuddy64/releases
# Refactored by Michael Fleet (github.com/f1337)

delimiter = '❤︎ '

options =
  theme: 'pastel'         # Theme options: 'pastel', 'dark', or 'bright'
  textColor: 'white'      # Color options: 'default' / html colors or values: 'black', 'white', '#000' etc

bullets = [
  '<span class="square">■</span>',
  '<span class="heart">♥</span>',
  '<span class="triangle">▼</span>',
  '<span class="circle">●</span>'
]

command: "./cuteical.widget/icalBuddy -nrd -nc -b '#{delimiter}' -eep 'location,url,notes,attendees' eventsFrom:now to:today"

# the refresh frequency s is seconds and m is minutes
refreshFrequency: '60s'

parseEvents: (output) ->
  events = []
  lines = output.split(delimiter)
  $.each lines, (idx, line) ->
    if line != ''
      [title, datetime, crlf] = line.split(/\n\s*/)
      [date, time] = datetime.split(' at ')
      bullet = bullets[idx % 4]
      events.push("""
        <div class="event_title">#{bullet} #{title}</div>
        <div class="event_time">#{time}</div>
      """)
  if events.length < 1
    events.push("""
      <div class="event_title">
        <span class="fire">☲</span> Let yesterday burn and throw it in the fire.
      </div>
    """)
  return events.join("\n")

render: (output) -> """
<div class="wrapper">#{output}</div>
"""

update: (output, domEl) ->
  events_html = @parseEvents(output)
  $(domEl).find('.wrapper').html("""
    <div class="today">
      <div class="title">Today</div>
      #{events_html}
    </div>
  """)



style: """
  font-family Helvetica Neue
  order: 1

  pastel_purple = #ccb5fc
  pastel_pink = #f4bdf7
  pastel_yellow = #fff49b
  pastel_green = #a0f2a4

  dark_purple = #250333
  dark_pink = #400122
  dark_yellow = #4A4104
  dark_green = #044A0B

  bright_purple = rgb(138, 116, 176)
  bright_pink = rgb(217,76,150)
  bright_yellow = rgb(239,199,44)
  bright_green = rgb(103,185,63)

  if #{options.theme} == pastel
    color1 = pastel_purple
    color2 = pastel_pink
    color3 = pastel_yellow
    color4 = pastel_green
    if #{options.textColor} == default
      text-color = #fff
    else
      text-color = #{options.textColor}
  else if #{options.theme} == dark
    color1 = dark_purple
    color2 = dark_pink
    color3 = dark_yellow
    color4 = dark_green
    if #{options.textColor} == default
      text-color = #000
    else
      text-color = #{options.textColor}
  else
    color1 = bright_purple
    color2 = bright_pink
    color3 = bright_yellow
    color4 = bright_green
    if #{options.textColor} == default
      text-color = #fff
    else
      text-color = #{options.textColor}


  div
    text-shadow: 0 0 1px rgba(#000, 0.5)
    font-size: 16px
    font-weight: 200
    display: block
    color: text-color

  .wrapper
    xxwidth:100%
    display:inline-block

  .title
    font-weight: 300
    font-size: 18px
    padding: 6px

  .event_title
    font-weight: 250
    padding-top: 5px
    padding-left: 10px
    margin-left: 1.1em
    text-indent: -1.1em

  .event_time
    font-weight: 200
    padding-left: 30px

  .today
    padding-bottom:10px

  .square
    font-size: 18px
    color: color1

  .heart
    font-size: 9px
    color: color2

  .triangle
    font-size: 9px
    color: color3

  .fire
    font-size: 18px
    color: color3

  .circle
    font-size: 18px
    color: color4
"""
