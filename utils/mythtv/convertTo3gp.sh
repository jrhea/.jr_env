#!/bin/sh
# MythTV user job to transcode a video to 3gp suitable for a phone
FILE=$1
TITLE=$2
OUTDIR="/tmp/"
/usr/bin/mythffmpeg -i $FILE -ar 16000 -ac 1 -acodec libamr_wb -ab 23.85k -b 240 -s qcif -f 3gp "$OUTDIR$TITLE.3gp"

# Uncomment the following line for a LG VX9900 (enV) video
#/usr/bin/ffmpeg -i $FILE -ar 16000 -ac 1 -acodec aac -ar 44100 -ab 128 -b 240 -s qcif -f 3gp "$OUTDIR$TITLE.3gp"
