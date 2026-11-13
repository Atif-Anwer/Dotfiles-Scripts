#!/bin/bash

sketchybar --add item front_app left \
           --set front_app background.drawing=on \
                           background.color=0xff6c7086 \
                           background.corner_radius=15 \
                           background.height=28 \
                           icon.color=$GREEN \
                           icon.font="SF Pro:Semibold:12.0" \
                           label.color=$GREEN \
                           label.font="sketchybar-app-font:Regular:12.0" \
                           label.padding_left=2 \
                           label.padding_right=10 \
                           icon.padding_left=10 \
                           icon.padding_right=2 \
                           script="$PLUGIN_DIR/front_app.sh" \
           --subscribe front_app front_app_switched aerospace_workspace_change
