gpio = require('rpi-gpio')
pin = 7

onChange = function (channel, value) {
  console.log('Channel ' + channel + ' value is now ' + value)
}

readInterval = function () {
  console.log('readInterval')
  gpio.read(pin, function (error, value) {
    console.log('read value is', value)
  })
}

onSetup = function (error) {
  setInterval(readInterval, 50)
}

gpio.setMode(gpio.MODE_RPI)
gpio.setup(pin, gpio.DIR_IN, onSetup)
gpio.on('change', onChange)