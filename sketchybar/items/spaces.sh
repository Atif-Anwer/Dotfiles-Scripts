#!/usr/bin/env bash
# shellcheck shell=bash
# Compatible with macOS /bin/bash 3.2 (no associative arrays).

source "$CONFIG_DIR/plugins/workspace_label.sh"
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/sketchybar_displays.sh"
source "$CONFIG_DIR/plugins/workspace_focus_style.sh"
source "$CONFIG_DIR/plugins/aerospace_monitors.sh"

sketchybar --add event aerospace_workspace_change 2>/dev/null || true

_cleanup_workspace_items() {
  local amid sid
  for sid in 0 1 2 3 4 5 6 7 8 9; do
    sketchybar --remove "space.$sid" 2>/dev/null || true
  done
  for amid in 1 2 3 4 5 6 7 8 9; do
    sketchybar --remove "monitor_pill.$amid" 2>/dev/null || true
    sketchybar --remove "monitor_sep.$amid" 2>/dev/null || true
  done
  sketchybar --remove monitor_pill.fallback 2>/dev/null || true
  sketchybar --remove space_creator 2>/dev/null || true
}

_cleanup_workspace_items

focused="$(aerospace list-workspaces --focused 2>/dev/null || true)"
DISPLAY_IDS="$(sketchybar_display_ids)"
SPACE_ADDED=""

_add_space_item() {
  local sid="$1"
  case " ${SPACE_ADDED} " in
    *" ${sid} "*) return 0 ;;
  esac
  SPACE_ADDED="${SPACE_ADDED} ${sid}"

  space=(
    icon="$sid"
    icon.highlight_color=$WORKSPACE_FOCUS
    icon.padding_left=8
    icon.padding_right=0
    padding_left=1
    padding_right=1
    label.padding_right=10
    label.color=$GREY
    label.highlight_color=$WORKSPACE_FOCUS
    label.y_offset=-1
    background.color=$BACKGROUND_1
    background.border_color=$BACKGROUND_2
    script="$CONFIG_DIR/plugins/space.sh"
    click_script="aerospace workspace $sid"
    display="$DISPLAY_IDS"
  )

  sketchybar --add item "space.$sid" left \
    --set "space.$sid" "${space[@]}" \
    --subscribe "space.$sid" mouse.clicked

  apply_workspace_display "$sid" "$focused"
}

_build_one_monitor_pill() {
  local amid="$1"
  local members=""
  local sid

  while read -r sid; do
    [ -z "$sid" ] && continue
    _add_space_item "$sid"
    if [ -z "$members" ]; then
      members="space.$sid"
    else
      members="${members} space.$sid"
    fi
  done < <(workspaces_on_aerospace_monitor "$amid" | sort_workspace_nums)

  [ -z "$members" ] && return 0

  # shellcheck disable=SC2086
  sketchybar --add bracket "monitor_pill.$amid" $members
  sketchybar --set "monitor_pill.$amid" \
    background.color=0xcc1e1e2e \
    background.corner_radius=18 \
    background.height=34 \
    background.padding_left=4 \
    background.padding_right=4 \
    display="$DISPLAY_IDS"

  sketchybar --add item "monitor_sep.$amid" left \
    --set "monitor_sep.$amid" \
    icon.drawing=off \
    label.drawing=off \
    padding_left=8 \
    padding_right=4 \
    display="$DISPLAY_IDS"
}

if aerospace list-monitors &>/dev/null; then
  for amid in $(aerospace list-monitors 2>/dev/null | awk -F'|' '{gsub(/^ *| *$/, "", $1); print $1}'); do
    [ -z "$amid" ] && continue
    _build_one_monitor_pill "$amid"
  done
else
  for sid in 0 1 2 3 4 5 6 7 8 9; do
    _add_space_item "$sid"
  done
  sketchybar --add bracket monitor_pill.fallback \
    space.0 space.1 space.2 space.3 space.4 space.5 space.6 space.7 space.8 space.9
  sketchybar --set monitor_pill.fallback \
    background.color=0xcc1e1e2e \
    background.corner_radius=18 \
    background.height=34 \
    display="$DISPLAY_IDS"
fi

apply_workspace_focus_styles "$focused"

space_creator=(
  icon=􀆊
  icon.font="SF Pro:Heavy:14.0"
  padding_left=8
  padding_right=6
  label.drawing=off
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$RED
  display="$DISPLAY_IDS"
)

sketchybar --add item space_creator left \
  --set space_creator "${space_creator[@]}" \
  --subscribe space_creator aerospace_workspace_change display_change
