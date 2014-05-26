#!/usr/local/bin/ node
gpio = require("rpi-gpio")
pin = 7
pirReadIntervalTime = 1500 # ms
pirTripped = false

onChange = (channel, value) ->
  console.log "Channel " + channel + " value is now " + value
  return

readInterval = ->
  gpio.read pin, (error, value) ->
    return unless value isnt pirTripped
    pirTripped = value
    if pirTripped then console.log 'tripped'
    else console.log 'waiting...'


onSetup = (error) ->
  setInterval readInterval, pirReadIntervalTime
  return

gpio.setMode gpio.MODE_RPI
gpio.setup pin, gpio.DIR_IN, onSetup
gpio.on "change", onChange