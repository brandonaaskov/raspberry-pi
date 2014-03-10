gpio = require("gpio")

gpio.open 11, "output", (error, value) ->
  console.log "open", value

  gpio.write 11, 1, (writeError, writeValue) ->
    console.log "write", writeValue
