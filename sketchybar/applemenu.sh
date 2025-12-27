#!/bin/bash

# ---------------------------------------------------
# Apple menu (leftmost item)
# ---------------------------------------------------

sketchybar --add item apple.logo left \
           --set apple.logo \
           icon=􀣺 \
           icon.font="$FONT:Black:16.0" \
           label.drawing=off \
           padding_left=6 \
           padding_right=20 \
           background.drawing=off\
           background.color=$BACKGROUND_1 \
           background.corner_radius=9 \
           background.border_width=2 \
           background.border_color=$BACKGROUND_2 \
           click_script="sketchybar --set \$NAME popup.drawing=toggle" \
           script="$PLUGIN_DIR/apple_hover.sh" \
           --subscribe apple.logo mouse.entered mouse.exited

# ---------------------------------------------------
# Popup items
# ---------------------------------------------------

sketchybar --add item apple.preferences popup.apple.logo \
           --set apple.preferences \
           icon=􀺽 \
           label="Preferences" \
           click_script="open -a 'System Preferences'; \
                         sketchybar --set apple.logo popup.drawing=off"

sketchybar --add item apple.activity popup.apple.logo \
           --set apple.activity \
           icon=􀒓 \
           label="Activity Monitor" \
           click_script="open -a 'Activity Monitor'; \
                         sketchybar --set apple.logo popup.drawing=off"

sketchybar --add item apple.lock popup.apple.logo \
           --set apple.lock \
           icon=􀒳 \
           label="Lock Screen" \
           click_script="pmset displaysleepnow; \
                         sketchybar --set apple.logo popup.drawing=off"

sketchybar --add item apple.restart popup.apple.logo \
           --set apple.restart \
           icon=􀅈 \
           label="Restart" \
           click_script="osascript -e 'tell app \"System Events\" to restart'; \
                         sketchybar --set apple.logo popup.drawing=off"

sketchybar --add item apple.shutdown popup.apple.logo \
           --set apple.shutdown \
           icon=􀆨 \
           label="Shut Down" \
           click_script="osascript -e 'tell app \"System Events\" to shut down'; \
                         sketchybar --set apple.logo popup.drawing=off"

# ---------------------------------------------------
# Auto-close popup when mouse leaves popup area
# ---------------------------------------------------

sketchybar --subscribe apple.logo mouse.exited \
           --set apple.logo \
           popup.drawing=off
