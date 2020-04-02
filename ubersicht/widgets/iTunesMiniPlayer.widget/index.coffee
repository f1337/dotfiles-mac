# Version: 0.0.2
refreshFrequency: 2000
style: """
    position:absolute
    margin: 0px
    bottom: 15px
    left: 15px
    width:200px
    border: 1px solid #FFF;
    color:#FFF
    min-height: 54px

    #cover
        display:block
        width: 200px
        height: 200px
    #cover img
        width: 200px
        height: 200px
    #content
        background: rgba(#000, .5)
        position: absolute
        padding: 10px 0
        bottom: 0
        width: 100%
        height: 72px
        text-align:center
        overflow:hidden
        border-top: 1px solid #FFF
    #content p
        width:1000px
        left: 50%;
        position: relative
        font-family: Helvetica Neue
        font-size: 12px
        line-height: 20px
        margin:0 0 10px -500px
        padding:0
"""

render: -> """
    <div id="cover"></div>
    <div id="content">
        <p><span id="iTunesArtist"></span></br><span id="iTunesTitle"></span></p>
    </div>
"""

command:    "osascript 'iTunesMiniPlayer.widget/iTunes.scpt'"

update: (output, domEl) ->
    iTunesvalues = output.split('~')

    if iTunesvalues[3] == 'playing'
        $(domEl).show()
    else
        $(domEl).hide()

    if $(domEl).find('#iTunesTitle').text() == iTunesvalues[0]
        return

    $(domEl).find('#iTunesArtist').text("#{iTunesvalues[1]}")
    $(domEl).find('#iTunesTitle').text("#{iTunesvalues[0]}")

    if iTunesvalues[0] != " " && iTunesvalues[1] != " "
        html = "<img src='iTunesMiniPlayer.widget/images/albumart.jpg'>"
        $(domEl).find('#cover').html("")
        $(domEl).find('#cover').html(html)
    else
        $(domEl).find('#cover').html("<img src='iTunesMiniPlayer.widget/images/default.png'>")