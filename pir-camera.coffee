#!/usr/local/bin/ node
gpio = require 'rpi-gpio'
RaspiCam = require 'raspicam'

pin = 7
pirReadIntervalTime = 1500 # ms
pirTripped = false

takePicture = ->
  cameraOptions =
    mode: 'photo'
    output: "/media/pictures/still_#{Date.now()}.png"
    w: 1280
    h: 720
    e: 'png' # encoding: jpg, bmp, gif, png
#  q: # quality (integer or string) set jpeg quality
    t: '2000' # timeout (in ms)
    tl: false # timelapse

  camera = new RaspiCam(cameraOptions)
  camera.start()

readInterval = ->
  gpio.read pin, (error, value) ->
    return if value is pirTripped
    pirTripped = value
    if pirTripped then takePicture()
    else console.log('waiting...')

onSetup = (error) ->
  if error then console.error(error)
  setInterval(readInterval, pirReadIntervalTime)

gpio.setMode(gpio.MODE_RPI)
gpio.setup(pin, gpio.DIR_IN, onSetup)