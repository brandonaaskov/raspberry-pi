// Generated by CoffeeScript 1.6.3
(function() {
  var gpio;

  gpio = require("gpio");

  gpio.open(11, "output", function(error, value) {
    console.log("open", value);
    return gpio.write(11, 1, function(writeError, writeValue) {
      return console.log("write", writeValue);
    });
  });

}).call(this);
