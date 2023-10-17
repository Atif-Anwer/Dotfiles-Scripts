#!/bin/bash

xrandr -s 0
xrandr --auto
echo "Resetting screen ..."
xrandr --output DP-4 --rate 165 --output DP-2 --primary --right-of DP-4 --rate 165
nitrogen --restore --force-setter=xinerama
