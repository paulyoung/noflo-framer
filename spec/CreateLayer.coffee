noflo = require 'noflo'
CreateLayer = require 'noflo-framer/components/CreateLayer.js'
{expect} = chai


describe 'CreateLayer component', ->
  component = null
  start = null
  layer = null


  beforeEach ->
    component = CreateLayer.getComponent()

    start = noflo.internalSocket.createSocket()
    component.inPorts.start.attach start

    layer = noflo.internalSocket.createSocket()
    component.outPorts.layer.attach layer


  describe 'creating a layer', ->
    it 'should produce a new layer', (done) ->
      layer.on 'data', (data) ->
        expect(data).to.be.instanceof window.Layer
        done()

      start.send()

    context 'with custom properties', ->
      it 'should produce a new layer with custom properties', (done) ->
        customProperties =
          width: -1

        layer.on 'data', (data) ->
          expect(data.properties.width).to.equal customProperties.width
          done()

        start.send customProperties
