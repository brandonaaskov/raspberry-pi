gpio = require("pi-gpio")

ledOn = true

setInterval ->
  gpio.open 11, "output", (err, value) ->
    gpio.write 11, (if ledOn then 0 else 1), (writeErr, writeValue) -> 
      console.log "write success"
      ledOn = if ledOn then false else true
      gpio.close 11
, 500
