#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

apply_workspace_focus_styles() {
  local fw="${1:-$(aerospace list-workspaces --focused 2>/dev/null)}"
  local i

  for i in 0 1 2 3 4 5 6 7 8 9; do
    if [ "$i" = "$fw" ]; then
      sketchybar --set "space.$i" \
        icon.highlight=false \
        label.highlight=false \
        icon.color="$WORKSPACE_FOCUS" \
        label.color="$WORKSPACE_FOCUS" \
        background.drawing=on \
        background.color="$WORKSPACE_FOCUS_BG" \
        background.border_color="$WORKSPACE_FOCUS" \
        background.corner_radius=15 \
        background.height=28 2>/dev/null || true
    else
      sketchybar --set "space.$i" \
        icon.highlight=false \
        label.highlight=false \
        icon.color="$GREY" \
        label.color="$GREY" \
        background.drawing=off \
        background.border_color="$BACKGROUND_2" 2>/dev/null || true
    fi
  done
}
