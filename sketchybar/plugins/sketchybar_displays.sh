#!/usr/bin/env bash

# SketchyBar display=1,2,3 — not display=active (active hides items on other monitors' bars).
# macOS seq -s, adds a trailing comma; that invalidates display= and hides every item.

sketchybar_display_ids() {
  local count i ids=""
  count="$(system_profiler SPDisplaysDataType 2>/dev/null | awk '/Resolution:/ { n++ } END { print n + 0 }')"
  [ "${count:-0}" -lt 1 ] && count=1
  for i in $(seq 1 "$count"); do
    [ -n "$ids" ] && ids="${ids},"
    ids="${ids}${i}"
  done
  printf '%s' "$ids"
}

_apply_item_display() {
  local ids="$1"
  shift
  local item
  for item in "$@"; do
    sketchybar --set "$item" display="$ids" 2>/dev/null || true
  done
}

apply_workspace_sketchybar_displays() {
  local ids i
  ids="$(sketchybar_display_ids)"
  for i in 0 1 2 3 4 5 6 7 8 9; do
    sketchybar --set "space.$i" display="$ids" 2>/dev/null || true
  done
}

apply_global_sketchybar_displays() {
  local ids amid
  ids="$(sketchybar_display_ids)"

  _apply_item_display "$ids" \
    apple_logo space_creator front_app \
    lock calendar network.download network.upload volume battery cpu memory clipboard \
    right_pill_bg

  while read -r amid; do
    [ -z "$amid" ] && continue
    _apply_item_display "$ids" "monitor_pill.$amid" "monitor_sep.$amid"
  done < <(aerospace list-monitors 2>/dev/null | awk -F'|' '{gsub(/^ *| *$/, "", $1); print $1}')

  apply_workspace_sketchybar_displays
}
