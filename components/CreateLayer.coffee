noflo = require 'noflo'
require 'framerjs'

createLayer = (properties) ->
  return new Layer properties

exports.getComponent = ->
  component = new noflo.Component
  component.description = 'Create a new layer.'
  component.icon = 'picture'

  # Add input ports
  component.inPorts.add 'start',
    datatype: 'bang'
    description: 'Create the layer with default properties.'
    process: (event, payload) ->
      # What to do when port receives a packet
      return unless event is 'data'
      newLayer = createLayer payload
      component.outPorts.layer.send newLayer

  # Add output ports
  component.outPorts.add 'layer',
    datatype: 'object'
    description: 'A new layer.'

  component
