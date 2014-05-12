gpio = require("pi-gpio")

ledOn = true

setInterval ->
  gpio.open 17, "output", (err, value) ->
    gpio.write 17, (if ledOn then 0 else 1), (writeErr, writeValue) ->
      console.log "Blink!" unless ledOn is 0
      ledOn = if ledOn then false else true
      gpio.close 17
, 1000
