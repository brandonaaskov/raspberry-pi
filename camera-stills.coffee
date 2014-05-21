RaspiCam = require 'raspicam'

options =
  mode: 'photo'
  output: '/dev/root/pictures/pic_%d.png'
  w: 1280
  h: 720
  e: 'png' # encoding: jpg, bmp, gif, png
#  q: # quality (integer or string) set jpeg quality
  t: '2000' # timeout (in ms)
  tl: false # timelapse

camera = new RaspiCam options

#to take a snapshot, start a timelapse or video recording
camera.start()

#to stop a timelapse or video recording
#camera.stop()

#listen for the "started" event triggered when the start method has been successfully initiated
camera.on 'started', -> console.log 'started'

#listen for the "read" event triggered when each new photo/video is saved
camera.on 'read', (err, filename) -> console.log 'saved'

#listen for the process to exit when the timeout has been reached
camera.on 'exited', -> console.log 'exited'