#!/usr/bin/env bash

# SketchyBar display=1,2,3 — not display=active (active hides items on other monitors' bars).

sketchybar_display_ids() {
  local count ids=""
  count="$(system_profiler SPDisplaysDataType 2>/dev/null | awk '/Resolution:/ { n++ } END { print n + 0 }')"
  [ "${count:-0}" -lt 1 ] && count=1
  ids="$(seq -s, 1 "$count")"
  printf '%s' "$ids"
}

apply_workspace_sketchybar_displays() {
  local ids
  ids="$(sketchybar_display_ids)"
  for i in 0 {1..9}; do
    sketchybar --set "space.$i" display="$ids"
  done
}
