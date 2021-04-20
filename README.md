# Streamer
Stream your Rasperry Pi camera's video to YouTube

---
## Getting Started

- Use [raspi-config](https://www.raspberrypi.org/documentation/configuration/raspi-config.md) to:
  - Set the Memory Split value to a value of at least 192MB
  - Enable the CSI camera interface
  - Set up your WiFi connection
- Connect the Raspberry Pi camera to your Raspberry Pi


## Installation

Installation of the program, as well as any software prerequisites, can be completed with the following two-line install script.

```
wget -q https://raw.githubusercontent.com/eat-sleep-code/streamer/main/install-streamer.sh -O ~/install-streamer.sh
sudo chmod +x ~/install-streamer.sh && ~/install-streamer.sh
```

---

## Usage
```
streamer <options>
```

### Options

+ _--key_ : Set the YouTube secret key    *(required)*
+ _--fps_ : Set the output framerate     *(default: 60)*
+ _--width_ : Set the horizontal resolution / width     *(default: 1920)*
+ _--height_ : Set the vertical resolution / width     *(default: 1080)*
+ _--bitrate_ : Set the output bitrate in MB/s   *(default: 15)*
+ _--rotate_ : Rotate the camera in 90&deg; increments     *(default: 0)*

---

## Get Your Key

You will need to acquire a Stream Key from YouTube.

---

## Autostart Stream
Want to start the stream every time you boot your Raspberry Pi?  Here is how!

* Review `/etc/systemd/system/streamer.service`
   * Replace `YOURKEYHERE` with the key your acquired in the step above.
* Run `~/camera.timelapse/install-streamer.service.sh`

---

## Infrared Cameras
If you are using an infrared (IR) camera, you will need to modify the Auto White Balance (AWB) mode at boot time.

This can be achieved by executing `sudo nano /boot/config.txt` and adding the following lines.

```
# Camera Settings 
awb_auto_is_greyworld=1
```

Also note, that while IR cameras utilize "invisible" (outside the spectrum of the human eye) light, they can not magically see in the dark.   You will need to illuminate night scenes with one or more to take advantage of an Infrared Camera.

---
:information_source: *This application was developed using a Raspberry Pi HQ (2020) camera and Raspberry Pi 3B+ and Raspberry Pi 4B boards. It has also been tested using v2.1 Raspberry Pi 8MP cameras.   Issues may arise if you are using either third party or older hardware.*
