gpio = require 'pi-gpio'

pirSensor = 7 # pi-gpio uses physical pin location, not broadcom

gpio.open pirSensor, 'input', ->
  console.log 'set to output'
  setInterval ->
    gpio.read pirSensor, (args...) -> console.log 'something', args
  , 100
gpio.open pirSensor, 'output', -> console.log 'set to output'
