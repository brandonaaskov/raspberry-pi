#!/usr/local/bin/ node

var gpio = require('rpi-gpio')
var RaspiCam = require('raspicam')

var pir = {
  pin: 12,
  time: 1500,
  tripped: false,
  value: undefined
}

var takePicture = function() {
  var cameraOptions = {
    mode: 'photo',
    output: "/media/pictures/still_" + (Date.now()) + ".png",
    w: 1280,
    h: 720,
    e: 'jpg', //encoding: jpg, bmp, gif, png
    q: 60, //quality (0-100) set jpeg quality
    t: '2000', //time (in ms) until picture is taken
    tl: false //timelapse
  }

  var camera = new RaspiCam(cameraOptions)
  camera.start()
}

var readInterval = function() {
  gpio.read(pir.pin, function(error, value) {
    // we only want to move on if something changed
    if (value === pir.tripped) return

    pir.tripped = value
    if (pir.tripped) takePicture()
    else console.log('waiting...')
  })
}

var onSetup = function(error) {
  if (error) console.error(error)
  return setInterval(readInterval, pir.time)
}

gpio.setMode(gpio.MODE_RPI)
gpio.setup(pir.pin, gpio.DIR_IN, onSetup)