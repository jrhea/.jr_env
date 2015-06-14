#!/bin/bash
# This is optional, I needed it.  You may not.  I actually ended up with sleep 10
/bin/sleep 10
/usr/bin/v4l2-ctl --verbose -d /dev/video0 --set-ctrl brightness=0x80 --set-ctrl contrast=0x40 --set-ctrl hue=0xf --set-ctrl saturation=0x40 --set-ctrl sharpness=0x80