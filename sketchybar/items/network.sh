#!/bin/bash

# Simple network monitor for SketchyBar

# Network download (left item)
sketchybar --add item network.download right \
           --set network.download \
                 icon="󰇚" \
                 icon.color=0xff8aadf4 \
                 icon.font="SF Pro:Bold:12.0" \
                 label="0 KB/s" \
                 label.color=0xff8aadf4 \
                 label.font="SF Pro:Bold:11.0" \
                 background.drawing=on \
                 update_freq=2 \
                 script="$PLUGIN_DIR/network.sh"

# Network upload (right item)  
sketchybar --add item network.upload right \
           --set network.upload \
                 icon="󰕒" \
                 icon.color=0xffed8796 \
                 icon.font="SF Pro:Bold:12.0" \
                 label="0 KB/s" \
                 label.color=0xffed8796 \
                 label.font="SF Pro:Bold:11.0" \
                 background.drawing=on \
                 update_freq=2 \
                 script="$PLUGIN_DIR/network.sh"
