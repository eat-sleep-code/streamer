from functions import Echo, Console
import argparse
import datetime
import os
import shutil
import subprocess
import sys
import threading
import time

version = '2021.04.20'

os.environ['TERM'] = 'xterm-256color'

console = Console()
echo = Echo()

# === Argument Handling ========================================================

parser = argparse.ArgumentParser()
parser.add_argument('--key', dest='key', help='Set the YouTube secret key', type=str, required=True)
parser.add_argument('--fps', dest='fps', help='Set the output framerate', type=int)
parser.add_argument('--width', dest='width', help='Set the horizontal resolution / width', type=int)
parser.add_argument('--height', dest='height', help='Set the vertical resolution / width', type=int)
parser.add_argument('--bitrate', dest='bitrate', help='Set the output bitrate in MB/s', type=int)
parser.add_argument('--rotate', dest='rotate', help='Rotate the camera in 90* increments', type=int)

args = parser.parse_args()


key = args.key or ''

fps = args.fps or 30
try:
	fps = int(fps)
except:
	fps = 30

width = args.width or 1920
try:
	width = int(width)
except:
	width = 1920


height = args.height or 1080
try: 
	height = int(height)
except:
	height = 1080

bitrate = args.bitrate or 15
try: 
	bitrate = int(bitrate)
except:
	bitrate = 15

# Convert Bitrate to be used by video program
if bitrate < 100:
	bitrate = bitrate * 1000000


rotate = args.rotate or 0
try: 
	rotate = int(rotate)
except:
	rotate = 0
	


# === Functions ================================================================

def StartStream():
	global key
	global fps
	global width
	global height
	global bitrate
	global rotate
	subprocess.Popen(['raspivid', '-o', '-', '-t', '0', '-vf', '-hf', '-fps', fps, '-w', width, '-h', height, '-b', bitrate, '|', 'avconv', '-re', '-ar', '44100', '-ac', '2', '-acodec', 'pcm_s16le', '-f', 's16le', '-ac', '2', '-i', '/dev/zero', '-f', 'h264', '-i', '-', '-vcodec', 'copy', '-acodec', 'aac', '-ab', '128k', '-g', '50', '-strict experimental', '-f', 'flv', 'rtmp://a.rtmp.youtube.com/live2/' + key], stdout=outputLog, stderr=errorLog)	
						

# === Stream Capture ========================================================

try: 
	echo.clear()
	os.chdir('/home/pi') 

	console.log('Streamer ' + version, '\n ')
	console.print('----------------------------------------------------------------------', '\n ', '\n ')
			
	StartStream()


except KeyboardInterrupt:
	echo.on()
	sys.exit(1)

except Exception as ex:
	console.error(ex)
	echo.on()

else:
	echo.on()
	sys.exit(0)
