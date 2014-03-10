gpio = require("pi-gpio")

ledOn = true

setInterval ->
  gpio.write 11, if ledOn then 0 else 1
  ledOn = if ledOn then false else true
, 2000