var gpio = require('rpi-gpio');
var async = require('async');

gpio.on('change', function(channel, value) {
  console.log('Channel ' + channel + ' value is now ' + value);
});

async.parallel([
  function(callback) {
    gpio.setup(7, gpio.DIR_OUT, callback)
  },
  function(callback) {
    gpio.setup(15, gpio.DIR_OUT, callback)
  },
  function(callback) {
    gpio.setup(16, gpio.DIR_OUT, callback)
  },
], function(err, results) {
  console.log('Pins set up');
  write();
});

function write() {
  async.series([
    function(callback) {
      delayedWrite(7, true, callback);
    },
    function(callback) {
      delayedWrite(15, true, callback);
    },
    function(callback) {
      delayedWrite(16, true, callback);
    },
    function(callback) {
      delayedWrite(7, false, callback);
    },
    function(callback) {
      delayedWrite(15, false, callback);
    },
    function(callback) {
      delayedWrite(16, false, callback);
    },
  ], function(err, results) {
    console.log('Writes complete, pause then unexport pins');
    setTimeout(function() {
      gpio.destroy(function() {
        console.log('Closed pins, now exit');
        return process.exit(0);
      });
    }, 500);
  });
};

function delayedWrite(pin, value, callback) {
  setTimeout(function() {
    gpio.write(pin, value, callback);
  }, 500);
}