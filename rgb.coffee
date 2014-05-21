gpio = require 'pi-gpio'

led =
  red: 11
  green: 13
  blue: 15

gpio.open led.red, "output", -> gpio.write led.red, 1