#!/bin/sh
# Script generated from ARandR utility
echo "Resetting screen ..."
# xrandr --output DP-0 --off --output DP-1 --off --output DP-3 --off --output HDMI-0 --off
xrandr -s 0
xrandr --auto
xrandr --output HDMI-0 --mode 1920x1080 --pos 2560x0 --rotate normal --rate 60 --right-of DP-4
xrandr --output DP-4 --primary --mode 2560x1600 --pos 0x0 --rotate normal --brightness 0.75 --rate 60
nitrogen --restore
