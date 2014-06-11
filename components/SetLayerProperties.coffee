noflo = require 'noflo'
require 'framerjs'

createLayer = (properties) ->
  return new Layer properties

exports.getComponent = ->
  component = new noflo.Component
  component.description = 'Set layer properties.'
  component.icon = 'cogs'

  # Add input ports
  component.inPorts.add 'in',
    datatype: 'object'
    description: 'The layer to set properties on.'
    process: (event, payload) ->
      # What to do when port receives a packet
      return unless event is 'data'
      component.layer = payload
      component.outPorts.layer.send payload

  component.inPorts.add 'properties',
    datatype: 'object'
    description: 'Properties to set on the layer.'
    process: (event, payload) ->
      # What to do when port receives a packet
      return unless event is 'data'
      component.layer[key] = value for key, value of payload
      component.outPorts.layer.send component.layer

  # Add output ports
  component.outPorts.add 'layer',
    datatype: 'object'
    description: 'The layer object passed as input.'

  component
