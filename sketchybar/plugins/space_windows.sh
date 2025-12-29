#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

reload_workspace_icon() {
  apps=$(aerospace list-windows --workspace "$@" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi

  sketchybar --set space.$@ label="$icon_strip"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  # Reload icons for all workspaces to catch window movements
  for i in {1..9}; do
    reload_workspace_icon "$i"
    sketchybar --set space.$i display=active
  done

  # Update highlighting for focused workspace
  sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE icon.highlight=true \
                         label.highlight=true \
                         background.border_color=$GREY

  # Remove highlighting from previous workspace
  sketchybar --set space.$AEROSPACE_PREV_WORKSPACE icon.highlight=false \
                         label.highlight=false \
                         background.border_color=$BACKGROUND_2
fi
