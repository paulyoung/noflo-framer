noflo = require 'noflo'
SetLayerProperties = require 'noflo-framer/components/SetLayerProperties.js'
{expect} = chai


describe 'SetLayerProperties component', ->
  component = null
  inPort = null
  properties = null
  layer = null


  beforeEach ->
    component = SetLayerProperties.getComponent()

    inPort = noflo.internalSocket.createSocket()
    component.inPorts.in.attach inPort

    properties = noflo.internalSocket.createSocket()
    component.inPorts.properties.attach properties

    layer = noflo.internalSocket.createSocket()
    component.outPorts.layer.attach layer


  describe 'setting properties', ->
    it 'should set properties', (done) ->
      inPort.send new window.Layer

      customProperties =
        width: -1

      layer.on 'data', (data) ->
        expect(data.properties.width).to.equal customProperties.width
        done()

      properties.send customProperties
