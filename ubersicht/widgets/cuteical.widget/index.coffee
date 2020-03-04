# Get calendar events on your desktop with cute bullets
# Made by Cara Takemoto
# Using icalBuddy: http://hasseg.org/icalBuddy/
# Updated icalBuddy with Catalina support from: https://github.com/DavidKaluta/icalBuddy64/releases
# Requires Python 2.7


options =
  widgetEnable: true      # To enable the widget, set value to true. To disable, false.
  theme: 'pastel'         # Theme options: 'pastel', 'dark', or 'bright'
  textColor: 'white'      # Color options: 'default' / html colors or values: 'black', 'white', '#000' etc


#This command shows all of your events for today and tomorrow

command: "python cuteical.widget/calendar_events_txtbullets.py"


# the refresh frequency s is seconds and m is minutes
refreshFrequency: '60s'

options : options

render: (output) -> "
<div class='wrapper'>#{output}</div>
"

update: (output, domEl) ->

  wrapper_display = $(domEl)

  if @options.widgetEnable

    wrapper_display.find('.wrapper').html(output)
  else
    wrapper_display.hide()



style: """
  font-family Helvetica Neue
  right: 10px
  top: 10px
  background: rgba(#000, .25)
  border-radius 4px
  width: 330px

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

  .circle
    font-size: 18px
    color: color4

"""