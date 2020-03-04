# Bing photo background created by Sam Roach 1/21/2016
# Unsplash photo background added by Michael Fleet 3/3/2020
# backgroud fades to black at the bottom of the screen to make a more usable space for other widgets.

accessKey = ""

# https://unsplash.com/documentation#get-a-random-photo
query = "beach" # search terms
collections = "" # Public collection ID(‘s) to filter selection. If multiple, comma-separated
# Filter search results by photo orientation. Valid values are landscape, portrait, and squarish.
orientation = "landscape"

command: """
curl -H 'Authorization: Client-ID #{accessKey}' -s 'https://api.unsplash.com/photos/random?query=#{query}&orientation=#{orientation}&collections=#{collections}'
"""

# Set the refresh frequency.
refreshFrequency: '24h'

style: """
  top: 0%
  left: 0%
  color: #fff

  .wallpaper
    position: absolute
    z-index: -10000
    width: 100%

  .background
    width: 100%
    position: absolute
    z-index: -10000

  .myimage
    width: 1920px
    position: absolute
    z-index: -10000

  .darker
    width: 1920px
    height: 300px
    color: green
    top: 900px
    position: absolute
    z-index: -9998
    background: linear-gradient(0deg, black, rgba(0, 0, 0, 0));

"""

render: -> """
<div id='background'></div>
<div class='darker'></div>

"""

# Update the rendered output.
update: (output, domEl) ->
  data = JSON.parse(output)
  console.log(data)
  url =  data.urls.regular
  mydiv = $(domEl).find('#background')
  html = ''
  html += "<div class='wallpaper'> "
  html += "<img src='" +url+ "' class='myimage' >"
  html += "</div>"

  # Set the output
  mydiv.html(html)
