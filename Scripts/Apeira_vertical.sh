#!/bin/sh
xrandr --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output HDMI-0 --mode 1920x1080 --pos 2560x0 --rotate left --output DP-4 --primary --mode 2560x1600 --rate 165 --pos 0x0 --rotate normal
nitrogen --restore
