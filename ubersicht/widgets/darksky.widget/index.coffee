# Überweather for Übersicht
# 04 March 2020
# by Michael Fleet (github/f1337)
#
# built upon the following work by others:
# * Authentic Weather for Übersicht, by by Itzael Martinez (https://github.com/reduxd/authentic-ubersicht)
# * DarkSky.Widget for Übersicht, by Gert Massheimer (https://github.com/DeltaOS2/darksky.widget)
# * Nice Weather Widget, by Li Xueli (https://github.com/mixj93/uebersicht-weather-widget)
#
# === User Settings ===================================================
#======================================================================
#--- standard iconSet is "color" (options are: color, mono)
iconSet = "mono"
#
#--- max 7 days for forecast plus today!
numberOfDays = 7
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
    snippetContent.push "#{ Math.round(t) }° "

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

  forecast = ''
  if numberOfDays > 8 then numberOfDays = 8
  if numberOfDays < 1 then numberOfDays = 1

  weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
  forecast += '<div class="weekdays">'
  for i in [0..numberOfDays-1]
    dayMin = Math.round(weatherData.daily.data[i].temperatureLow.toFixed(1))
    dayMax = Math.round(weatherData.daily.data[i].temperatureHigh.toFixed(1))
    day = new Date(weatherData.daily.data[i].time * 1000).getDay()
    weekday = weekDays[day]
    dayIconName = weatherData.daily.data[i].icon
    dayIcon = 'darksky.widget/images/' + iconSet + '/' + dayIconName + '.png'
    forecast += '<div class="weekday-col">' + "\n"
    forecast += '<p class="temp-low">' + dayMin + '</p>' + "\n"
    forecast += '<p class="temp-high">' + dayMax + '</p>'
    forecast += '<img class="weekday-icon" src="' + dayIcon + '" alt="' + dayIconName + '">' + "\n"
    forecast += '<p class="weekday-name">' + weekday + '</p>' + "\n"
    forecast += '</div>'
  forecast += '</div>'

  $(domEl).find('.forecast').html(forecast)

# --- style settings
style: """
  font-family: 'HelveticaNeue-Light', 'Helvetica Neue Light', 'Helvetica Neue', Helvetica, 'Open Sans', 'sans-serif';
  color: #ffffff;
  order: 0

  .forecast
    color #c1e1f1
    font-weight 400
    font-size .7rem
    font-family system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto",
      "Oxygen", "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue",
      sans-serif

  .weather
    overflow-y hidden;
    padding .5rem

  .temp-low
    color #5ebadc
    font-weight 500
    font-size .8rem
    margin 0 0 4px 0

  .temp-high
    color #e22e4f
    font-weight 500
    font-size .8rem
    margin 0

  .weekdays
    display flex
    justify-content space-between

  .weekday-col
    color #fff
    text-align center

  .weekday-name
    font-weight 500
    margin 0

  .weekday-icon
    width 20px
    height 20px
    margin 4px 0

	#snippet
		font-size 6em
		font-weight 500
		line-height 1em
    padding 0
    margin 0

		img
			max-width 100px
			vertical-align text-bottom

	h1
		font-size 3em
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
