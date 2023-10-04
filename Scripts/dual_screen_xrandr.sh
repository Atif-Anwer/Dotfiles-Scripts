#!/bin/sh
xrandr --auto --output DP-4 --mode 2560x1600 --right-of HDMI-0
xrandr --output HDMI-0 --rotate left
xrandr --output DP-4 --brightness 0.75
