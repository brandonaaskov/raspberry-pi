import io
import time
import picamera
import RPi.GPIO as GPIO

stream = None

def write_video(stream):
    print('Writing video!')
    with stream.lock:
        # Find the first header frame in the video
        for frame in stream.frames:
            if frame.header:
                stream.seek(frame.position)
                break
        # Write the rest of the stream to disk
        with io.open(get_filename(), 'wb') as output:
            output.write(stream.read())
            print('file written')

def get_filename():
    timestamp = round(time.time())
    filename = 'recordings/recording_{stamp}.h264'.format(stamp=timestamp)
    return filename

with picamera.PiCamera() as camera:
    camera.rotation = 90
    stream = picamera.PiCameraCircularIO(camera, seconds=10)
    filename = get_filename()
    print('setup finished')

    print('first file: ' + filename)
    camera.start_recording(filename, format='h264', bitrate=2500000)

    try:
        button = 17
        GPIO.setmode(GPIO.BCM)
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(button, GPIO.IN, pull_up_down=GPIO.PUD_UP)

        while True:
            input_state = GPIO.input(button)
            if input_state == False:
                filename = get_filename()
                print('pushed - splitting recording: ' + filename)
                camera.split_recording(filename)
                time.sleep(0.2)
                write_video(stream)
            pass
    finally:
        camera.stop_recording()
