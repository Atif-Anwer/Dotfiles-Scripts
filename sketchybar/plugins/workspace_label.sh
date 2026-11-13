#!/usr/bin/env bash

set -o pipefail

CONFIG_DIR="${CONFIG_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

APP_ICON_FONT="sketchybar-app-font:Regular:14.0"
NUMBER_FONT="SF Pro:Semibold:12.0"

_workspace_apps() {
  local sid="$1"
  aerospace list-windows --workspace "$sid" 2>/dev/null | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}'
}

_glyph_strip() {
  local apps="$1"
  local strip=" "
  while read -r app; do
    [ -z "$app" ] && continue
    strip+=" $("$CONFIG_DIR/plugins/icon_map.sh" "$app")"
  done <<< "$apps"
  printf '%s' "$strip"
}

_is_focused_ws() {
  local sid="$1"
  local focused="$2"
  [ -n "$focused" ] && { [ "$sid" = "$focused" ] || [ "space.$sid" = "$focused" ]; }
}

# Number always in icon (visible on every monitor). App icons in label. Focus = highlight only.
apply_workspace_display() {
  local sid="$1"
  local focused="${2:-}"
  local item="space.$sid"

  if [ -z "$focused" ]; then
    focused="$(aerospace list-workspaces --focused 2>/dev/null || true)"
  fi

  local apps glyphs="" label_drawing=off
  apps="$(_workspace_apps "$sid")"

  if [ -n "$apps" ]; then
    glyphs="$(_glyph_strip "$apps")"
    label_drawing=on
  elif _is_focused_ws "$sid" "$focused"; then
    glyphs=" —"
    label_drawing=on
  fi

  sketchybar --set "$item" \
    icon="$sid" \
    icon.drawing=on \
    icon.font="$NUMBER_FONT" \
    icon.padding_left=10 \
    icon.padding_right=4 \
    label="$glyphs" \
    label.font="$APP_ICON_FONT" \
    label.drawing="$label_drawing" \
    label.padding_left=2 \
    label.padding_right=12
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  apply_workspace_display "${1:?workspace id}" "${2:-}"
fi
