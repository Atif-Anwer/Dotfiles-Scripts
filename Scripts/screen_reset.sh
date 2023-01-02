#!/bin/bash

xrandr -s 0
xrandr --auto
echo "Resetting screen ..."
xrandr --output DP-4 --primary --rate 165 --output DP-1-3 --left-of DP-4
nitrogen --restore
