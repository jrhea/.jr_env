#!/bin/bash

# Matt 8/09
# Clone a hard drive. Mount the from and to drives then
# define FROMDIR and TODIR where you mounted them and
# run this script to clone FROMDIR to TODIR. Or you
# may mount the to drive and clone the system drive
# by defining FROMDIR=/
# NOTE1: a mounted boot partition ($FROMDIR/boot) is looked
# for and if found, this script checks to make sure you
# mounted a new boot partition to copy to at $TODIR/boot,
# otherwise if $FROMDIR/boot is not a mounted partition
# then this script just copies it as a normal dir.
# NOTE2: if copying the system drive, make sure you unmount
# all partitions except / and /boot (or add a prune statement
# below), otherwise the other partitions will get copied.
# NOTE3: If copying a system drive, you must install the
# bootloader to the new drive afterwards.

CURDIR=`pwd`
PROC="no"
SYS="no"
# Adjust the following. FROMDIR= where you want to copy from.
# TODIR= where you want to copy to.
FROMDIR=/
TODIR=/mnt

if [ ! -e $FROMDIR ]; then
  echo "$FROMDIR not found. Aborted."
  exit
fi
if [ ! -e $TODIR ]; then
  echo "$TODIR not found. Aborted."
  exit
fi

/bin/mountpoint -q $FROMDIR/boot
BOOTISMOUNT=$?
if [ "$BOOTISMOUNT" = "0" ]; then
  if [ ! -e $TODIR/boot ]; then
    echo ""
    echo "$FROMDIR/boot is a mount point while"
    echo "$TODIR/boot not found at all. Aborted."
    echo ""
    exit
  else
    /bin/mountpoint -q $TODIR/boot
    TOBOOTISMOUNT=$?
    if [ "$TOBOOTISMOUNT" = "1" ]; then
      echo ""
      echo "$FROMDIR/boot is a mount point while"
      echo "$TODIR/boot is not. Aborted."
      echo ""
      exit
    fi
  fi
fi

if [ -e $FROMDIR/proc ]; then
  PROC="yes"
fi
if [ -e $FROMDIR/sys ]; then
  SYS="yes"
fi

cd $FROMDIR
/usr/bin/find . \
-path ./lost+found -prune \
-or -path ./boot/lost+found -prune \
-or -path ./proc -prune \
-or -path ./sys -prune \
-or -name .volume.inf -prune \
-or -name core -prune \
-or -name "core.*" -prune \
-or -path .$TODIR -prune \
-or -path ./mnt -prune \
-or -print | /bin/cpio -pdamv $TODIR 


if [ "$PROC" = "yes" ]; then
  /bin/mkdir $TODIR/proc
  /bin/chmod 555 $TODIR/proc
fi
if [ "$SYS" = "yes" ]; then
  /bin/mkdir $TODIR/sys
  /bin/chmod 755 $TODIR/sys
fi

cd $CURDIR

