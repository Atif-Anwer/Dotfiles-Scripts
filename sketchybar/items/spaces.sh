#!/usr/bin/env bash

source "$CONFIG_DIR/plugins/workspace_label.sh"
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/sketchybar_displays.sh"
source "$CONFIG_DIR/plugins/workspace_focus_style.sh"

sketchybar --add event aerospace_workspace_change

focused="$(aerospace list-workspaces --focused 2>/dev/null || true)"

for i in 0 {1..9}; do
  sid=$i

  space=(
    icon="$sid"
    icon.highlight_color=$WORKSPACE_FOCUS
    icon.padding_left=10
    icon.padding_right=0
    padding_left=2
    padding_right=2
    label.padding_right=20
    label.color=$GREY
    label.highlight_color=$WORKSPACE_FOCUS
    label.y_offset=-1
    background.color=$BACKGROUND_1
    background.border_color=$BACKGROUND_2
    script="$CONFIG_DIR/plugins/space.sh"
    click_script="aerospace workspace $sid"
    display="$(sketchybar_display_ids)"
  )

  sketchybar --add item "space.$sid" left \
    --set "space.$sid" "${space[@]}" \
    --subscribe "space.$sid" mouse.clicked

  apply_workspace_display "$sid" "$focused"

done

apply_workspace_focus_styles "$focused"

space_creator=(
  icon=􀆊
  icon.font="SF Pro:Heavy:14.0"
  padding_left=10
  padding_right=8
  label.drawing=off
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator left \
  --set space_creator "${space_creator[@]}" \
  --subscribe space_creator aerospace_workspace_change display_change

apply_workspace_sketchybar_displays
