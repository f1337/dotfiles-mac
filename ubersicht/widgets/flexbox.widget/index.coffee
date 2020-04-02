alignItems     : 'stretch'    # default: 'stretch'
alignContent   : 'stretch'    # default: 'stretch'
flexDirection  : 'column'        # default: 'row'
flexWrap       : 'nowrap'       # default: 'nowrap'
justifyContent : 'flex-start' # default: 'flex'-start'

refreshFrequency: false

command: "echo"

render: (output) -> """
  <style>
    #__uebersicht {
      display: flex;
      align-items: #{@alignItems};
      align-content: #{@alignContent};
      flex-direction: #{@flexDirection};
      flex-wrap: #{@flexWrap};
      justify-content: #{@justifyContent};
    }
    #__uebersicht>div {
      width: auto;
    }
    .widget {
      background: rgba(0, 0, 0, .33);
      border-radius: 6px;
      margin: 14px;
      position: relative;
      width: 330px;
    }
  </style>
  """

update: (output, domEl) ->
  $(domEl).parent('div').css('position', 'absolute')
