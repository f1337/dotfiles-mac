# Bing photo background created by Sam Roach 1/21/2016
# Unsplash photo background added by Michael Fleet 3/3/2020

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
refreshFrequency: '1h'

style: """
  position: absolute;
  margin: 0
  top: 0
  left: 0
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
    position: absolute
    z-index: -10000
    object-fit: cover
    height: 100vh
"""

render: -> """
<div id='background'></div>
"""

# Update the rendered output.
update: (output, domEl) ->

  if (output == '')
    return

  data = JSON.parse(output)
  size = "width: " + window.screen.availWidth + "px;"

  url =  data.urls.regular
  if (url)
    mydiv = $(domEl).find('#background')
    html = ''
    html += '<div class="wallpaper"> '
    html += '<img src="' + url + '" class="myimage" style="' + size + '">'
    html += '</div>'

    # Set the output
    mydiv.html(html)
