# Code originally created by the awesome members of Ubersicht community.
# I stole from so many I can't remember who you are, thank you so much everyone!
# Haphazardly adjusted and mangled by Pe8er (https://github.com/Pe8er)

options =
  # Easily enable or disable the widget.
  widgetEnable: true

refreshFrequency: '2s'

# --- do not modify above this line

command: "python iTunesLyrics.widget/get_lyrics.py"
artist: ""
song: ""

style: """
  white05 = rgba(white,0.5)
  white02 = rgba(white,0.2)

  width 330px
  height 60%
  bottom 15px
  right 15px
  position absolute
  -webkit-backdrop-filter blur(20px) brightness(60%) contrast(130%) saturate(140%)
  font-family system, -apple-system
  opacity 0
  padding 16px
  -webkit-transition height 250ms ease-in-out
  overflow-y scroll

  .wrapper
    font-size 8pt
    line-height 11pt
    color white

  .song
    font-weight 700
    padding-bottom 8px
    margin-bottom 8px
    border-bottom 1px white02 solid
"""

options : options

render: (output) ->

  # Initialize our HTML.
  lyricsHTML = ''

  # Create the DIVs for each piece of data.
  lyricsHTML = "
    <div class='wrapper'>
      <div class='artist'></div>
      <div class='song'></div>
      <div class='lyrics'></div>
    </div>"

  return lyricsHTML

# Update the rendered output.
update: (output, domEl) ->
  console.log(output)
  return
  metadata = JSON.parse(output)
  console.log(metadata, @song, @artist)

  if @song == metadata['song'] and @artist == metadata['artist']
    console.log('nothing changed')
    return
  else
    @artist = metadata['artist']
    @song = metadata['song']

  # Get our main DIV.
  div = $(domEl)

  if @options.widgetEnable
    # Initialize our HTML.
    lyricsHTML = ''

    if metadata['state'] != 'playing'
      console.log('not playing')
      div.animate({ opacity: 0 }, 250)
    else
      console.log('updating lyrics')
      artistName = metadata['artist']
      songName = metadata['song']
      lyrics = metadata['lyrics']

      div.animate({ opacity: 1 }, 250)
      div.find('.artist').html(artistName)
      div.find('.song').html(songName)
      div.find('.lyrics').html(lyrics)

    # wrapHeight = div.find('.wrapper').height()
    # totalHeight = screen.height
    # div.css('height', wrapHeight)
    # div.css('max-height', totalHeight - 48)
  else
    div.hide()
