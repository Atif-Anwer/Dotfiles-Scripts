#!/bin/bash

xrandr -s 0
xrandr --auto
echo "Resetting screen ..."
xrandr --output eDP-1 --primary --rate 144 --output DP-1-3 --left-of eDP-1
