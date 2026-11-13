#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/workspace_label.sh"
source "$CONFIG_DIR/plugins/sketchybar_displays.sh"
source "$CONFIG_DIR/plugins/workspace_focus_style.sh"

if [ "$SENDER" = "display_change" ]; then
  apply_global_sketchybar_displays
  exit 0
fi

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  fw="${AEROSPACE_FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

  for i in 0 {1..9}; do
    apply_workspace_display "$i" "$fw"
  done
  apply_global_sketchybar_displays
  apply_workspace_focus_styles "$fw"
fi
