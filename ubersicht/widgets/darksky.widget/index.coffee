#
# Name: DarkSky.Widget
# Destination App: Übersicht
# Created: 09.Jan.2019
# Author: Gert Massheimer
#
# === User Settings ===================================================
#======================================================================
#--- standard iconSet is "color" (options are: color, mono)
iconSet = "mono"
#
#--- max 7 days for forecast plus today!
numberOfDays = 7
#
#--- max number of weather alerts
numberOfAlerts = 1
#
#--- show weather alerts (show = true ; don't show = false)
showAlerts = true
#showAlerts = false
#
#--- your API-key from DarkSky (https://darksky.net/dev)
apiKey = ""
#
#--- select the language (possible "de" for German or "en" for English)
# lang = 'de' # deutsch
lang = 'en' # english
#
#--- select how the units are displayed
# units = 'ca' # Celsius and km
units = 'us' # Fahrenheit and miles
#
# icon set; 'black', 'white', and 'blue' supported
icon: 'white'
#
# weather icon above text; true or false
showIcon: true
#
# temperature above text; true or false
showTemp: true
#
refreshFrequency: '15m' # every 15 minutes
#=== DO NOT EDIT AFTER THIS LINE unless you know what you're doing! ===
#======================================================================

exclude: "minutely,hourly,alerts,flags"

command: "echo {}"

makeCommand: (apiKey, location) ->
  "curl -sS 'https://api.forecast.io/forecast/#{apiKey}/#{location}?lang=#{lang}&units=#{units}&exclude=#{@exclude}'"

render: ->
  """
	<article class="weather">
		<!-- snippet -->
		<div id="snippet">
		</div>

		<!--phrase text box -->
		<h1>
		</h1>

		<!-- subline text box -->
		<h2>
		</h2>

		<!-- forecast -->
    <div class="forecast"></div>
	</article>
  """

afterRender: (domEl) ->
  geolocation.getCurrentPosition (e) =>
    coords     = e.position.coords
    [lat, lon] = [coords.latitude, coords.longitude]
    @command   = @makeCommand(apiKey, "#{lat},#{lon}")

    @refresh()

updateCurrent: (data, dom) ->
	# get current temp from json
	t = data.currently.temperature

	# process condition data (1/2)
	s1 = data.currently.icon
	s1 = s1.replace(/-/g, "_")

	# snippet control

	snippetContent = []

	# icon dump from android app
	if @showIcon
		snippetContent.push "<img src='darksky.widget/icon/#{ @icon }/#{ s1 }.png'></img>"

	if @showTemp
    snippetContent.push " #{ Math.round(t) }° "

	$(dom).find('#snippet').html snippetContent.join ''

	# process condition data (2/2)
	s1 = s1.replace(/(day)/g, "")
	s1 = s1.replace(/(night)/g, "")
	s1 = s1.replace(/_/g, " ")
	s1 = s1.trim()

	# get relevant phrase
	if units == 'us'
		@parseStatus(s1, Math.round((t - 32) * 5 / 9), dom)
	else
		@parseStatus(s1, t, dom)

# phrases dump from android app
parseStatus: (summary, temperature, dom) ->
	c = []
	s = []
	$.getJSON "darksky.widget/#{lang}/phrases.json", (data) ->
		$.each data.phrases, (key, val) ->
			# condition based
			if val.condition == summary
				if val.min < temperature
					if val.max > temperature
						c.push val
						s.push key

					if typeof val.max == 'undefined'
						c.push val
						s.push key

				if typeof val.min == 'undefined'
					if val.max > temperature
						c.push val
						s.push key

					if typeof val.max == 'undefined'
						c.push val
						s.push key

			# temp based
			if typeof val.condition == 'undefined'
				if val.min < temperature
					if val.max > temperature
						c.push val
						s.push key

					if typeof val.max == 'undefined'
						c.push val
						s.push key

				if typeof val.min == 'undefined'
					if val.max > temperature
						c.push val
						s.push key

					if typeof val.max == 'undefined'
						c.push val
						s.push key

		r = c[Math.floor(Math.random()*c.length)]

		title = r.title
		highlight = r.highlight[0]
		color = r.color
		sub = r.subline
		nextTest = s[Math.floor(Math.random()*c.length)]

		text = title.replace(/\|/g, " ")

		c1 = new RegExp(highlight, "g")
		c2 = "<i style=\"color:" + color + "\">" + highlight + "</i>"

		text2 = text.replace(c1, c2)
		text3 = text2.replace(/>\?/g, ">")

		$(dom).find('h1').html text3
		$(dom).find('h2').html sub

update: (output, domEl) ->

  weatherData = JSON.parse(output)
  return unless weatherData.currently?

  @updateCurrent(weatherData, domEl)

  # --- generate weather alert message only if there is alert
  forecast = ''; dayMaxTemp = 0; weekMaxTemp = 0;
  if weatherData.hasOwnProperty('alerts') && showAlerts == true
    if numberOfAlerts < weatherData.alerts.length then maxAlerts = numberOfAlerts
    else maxAlerts = weatherData.alerts.length

    for i in [0..maxAlerts-1]

      alertTitle = weatherData.alerts[i].title

      if lang == 'de' then areaCode = 'de-DE'
      else areaCode = 'en-US'
      alertTime    = new Date(weatherData.alerts[i].time * 1000).toLocaleDateString(areaCode, { weekday: 'short', year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric' })
      alertExpires = new Date(weatherData.alerts[i].expires * 1000).toLocaleDateString(areaCode, { weekday: 'short', year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric' })

      alertDescription = weatherData.alerts[i].description
      alertRegions = weatherData.alerts[i].regions

      alertSeverity = weatherData.alerts[i].severity
      switch alertSeverity
        when 'advisory'
          alertSeverity = 0
          levelCSS = 'alert-level0'
        when 'watch'
          alertSeverity = 1
          levelCSS = 'alert-level1'
        when 'warning'
          alertSeverity = 2
          levelCSS = 'alert-level2'

      if lang == 'de'
        alertSeverity = ['Niedrig', 'Mittel', 'Hoch'][alertSeverity];
      else
        alertSeverity = ['Low', 'Middle', 'High'][alertSeverity];

      # --- show the weather alert(s)
      style = ' style="max-width:25rem;padding-bottom:1.5rem;"'
      forecast += '<table style="max-width:35rem;"><tr><td style="vertical-align:top;padding-top:1rem">'
      forecast += '<img src="darksky.widget/images/alert/alert.gif" alt="" />'
      forecast += '</td><td' + style + '>'
      forecast += '<span class="alert-type">'
      forecast += alertTitle
      forecast += '</span>'

      forecast += '<br><span class="alert-region">'
      if lang == 'de' then forecast += 'Region(en): '
      else forecast += ' Region(s): '
      forecast += alertRegions + '</span>'

      forecast += '<br><span class="alert-level">'
      if lang == 'de' then forecast += 'Gefahrenstufe:</span> '
      else forecast += ' Severity Level:</span> '
      forecast += '<span class="' + levelCSS + '">' + alertSeverity + '</span>'

      forecast += '<br><span class="alert-start">'
      if lang == 'de' then forecast += 'Begint: '
      else forecast += 'Starts: '
      forecast += '</span><span class="alert-starttime">'
      forecast += alertTime
      forecast += '</span>'

      forecast += '<br><span class="alert-expires">'
      if lang == 'de' then forecast += 'Endet: '
      else forecast += 'Expires: '
      forecast += '</span><span class="alert-endtime">'
      forecast += alertExpires
      forecast += '</span></td></tr>'

      forecast += '<tr><td colspan="2"><span class="alert-desc">'
      forecast += alertDescription + '</span>'
      forecast = forecast.replace(/\n/g, " ")
      forecast = forecast.replace(/\*/g, "<br>* ")

      forecast += '</td></tr></table>'
      $(domEl).find('.forecast').html(forecast)

  # --- generate the eight days weather columns
  else
    if numberOfDays > 8 then numberOfDays = 8
    if numberOfDays < 1 then numberOfDays = 1

    # numberOfDays = 8

    if units == 'ca'
      forecast += '<table><tr>'
    else
      forecast += '<table class="table-bar"><tr>'

    # compute the hottest temperature of the forecast range to set the highest position of the dayBar
    for i in [0..numberOfDays-1]
      dayMaxTemp = Math.round(weatherData.daily.data[i].temperatureHigh)
      if weekMaxTemp <= dayMaxTemp then weekMaxTemp = dayMaxTemp

    for i in [0..numberOfDays-1]
      dayMin = Math.round(weatherData.daily.data[i].temperatureLow.toFixed(1))
      dayMax = Math.round(weatherData.daily.data[i].temperatureHigh.toFixed(1))
      if units == 'ca' then pos = 75
      else pos = 120
      wDayShort   = new Date(weatherData.daily.data[i].time * 1000).getDay()
      if lang == 'de'
        wDayShort = ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'][wDayShort];
      else
        wDayShort = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'][wDayShort];

      dayIconName = weatherData.daily.data[i].icon
      dayIcon = 'darksky.widget/images/' + iconSet + '/' + dayIconName + '.png'

      wDayBar = (weekMaxTemp - (dayMax * 2)) + pos # position of the bar from top
      dayBar  = (dayMax - dayMin + 5) * 2          # length / height of the bar

      # --- show the temperature columns
      forecast += '<td class="weekday-col"><div class="weekday-name">'
      if lang == 'de' then today = 'Heute'
      else today = 'Today'
      if i == 0 then forecast += today
      else forecast += wDayShort
      forecast += '</div><div class="weekday-icon"><img style="height:30px;width:30px;" src="'
      forecast += dayIcon
      forecast += '" alt="" /></div><div class="wdb" style="top:'
      forecast += wDayBar
      forecast += 'px;">'
      forecast += '<span class="temp-high" style="line-height:1.8">' + dayMax + '°</span>'
      forecast += '<br /><div class="db" style="height: '
      forecast += dayBar
      forecast += 'px;">'
      forecast += '</div><br />'
      forecast += '<span class="temp-low" style="line-height:1.4">' + dayMin + '°</span>'
      forecast += '</div></td>'

    forecast += '</tr></table>'

    $(domEl).find('.forecast').html(forecast)

# --- style settings
style: """
  // position of the widget on the screen
  top 15px
  left 15px
  width: 330px;

  font-family: 'HelveticaNeue-Light', 'Helvetica Neue Light', 'Helvetica Neue', Helvetica, 'Open Sans', 'sans-serif';
  color: #ffffff;

  table
    border-spacing 0
    padding 0
    margin 0
    max-width 28rem
    width 100%

  th, td
    margin 0.1rem 0.5rem;
    padding 0

  td
    display table-cell
    max-width 16rem
    vertical-align middle

  .forecast
    color #c1e1f1
    font-weight 400
    font-size .7rem
    font-family system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto",
      "Oxygen", "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue",
      sans-serif

  .weather
    background rgba(#000, .25)
    border-radius 4px
    overflow-y hidden;
    padding .5rem

  .text-container
    padding 15px
    float right

  .image-container
    padding 0
    float left

  .location
    color #26b6d0
    font-weight 400
    font-size 1.25rem

  .conditions
    color #26b6d0
    font-weight bold
    font-size .9rem

  .time
    color #93cdda
    font-weight bold
    font-size .75rem
    padding-top .2rem
    padding-bottom .2rem

  .headline
    color #78d8ff
    font-weight 400
    font-size .8rem

  .temp-low
    color #5ebadc
    font-weight 500
    font-size .8rem

  .temp-high
    color #e22e4f
    font-weight 500
    font-size .8rem

  .summary
    color #26b6d0
    font-weight 500
    font-size .75rem

  .image
    float left
    padding 5px 10px 0 10px

  .wind
    color #c1e1f1
    font-size .75rem
    font-weight 300

  // Styles for display = icon

  .table-bar
    padding-bottom 2rem

  .weekday-col
    position relative
    color #fff
    height 10rem
    width 2rem
    white-space nowrap
    text-align center

  .weekday-name
    position absolute
    top 0
    height 1rem
    width 2rem
    font-weight 500

  .weekday-icon
    position absolute
    top 1rem
    height 2rem
    width 2rem

  .wdb
    position absolute
    height 4rem
    width 2rem

  .db
    background-color #fff
    display inline-block
    width .5rem
    padding .2rem
    border-radius .5rem
    border 2px solid #5ebadc

  // Styles for alerts

  .alert-type
    color #e22e4f
    font-weight 800
    font-size 1.4rem
    line-height 1.5

  .alert-region
    color #ddd
    font-weight 300
    font-size .9rem
    line-height 1.5

  .alert-level
    color #ddd
    font-weight 300
    font-size 1rem
    line-height 1.5

  .alert-level0
    color #00f900
    font-size 1rem

  .alert-level1
    color #ffc543
    font-size 1rem

  .alert-level2
    color #db2d36
    font-size 1rem

  .alert-start,
  .alert-expires
    color #ddd
    font-weight 400
    font-size .8rem
    line-height 1.3

  .alert-starttime,
  .alert-endtime
    color #e2ba2e
    font-weight 300
    font-size .8rem
    line-height 1.3

  .alert-desc
    color #c1e1f1
    font-weight 300
    font-size .8rem
    line-height 1.5

	#snippet
		font-size 5em
		font-weight 500
		line-height 1em
    padding 0
    margin 0

		img
			max-width 100px
			vertical-align bottom

	h1
		font-size 3.3em
		font-weight 600
		line-height 1em
		letter-spacing -0.04em
		margin 0 0 0 0

	h2
		font-weight 500
		font-size 1em

	i
		font-style normal
"""
