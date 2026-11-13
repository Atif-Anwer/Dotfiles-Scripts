#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

update_front_app() {
  local app="${INFO:-}"
  local ws glyph

  if [ -z "$app" ]; then
    app="$(aerospace list-windows --focused --format '%{app-name}' 2>/dev/null || true)"
  fi
  ws="$(aerospace list-workspaces --focused 2>/dev/null || true)"

  if [ -z "$app" ]; then
    sketchybar --set "$NAME" \
      icon="${ws}" \
      icon.font="SF Pro:Semibold:12.0" \
      icon.drawing=on \
      icon.color="$GREEN" \
      label.drawing=off
    return
  fi

  glyph="$("$CONFIG_DIR/plugins/icon_map.sh" "$app")"

  # Number left (SF Pro), app glyph right — matches workspace pill order.
  sketchybar --set "$NAME" \
    icon="${ws}" \
    icon.font="SF Pro:Semibold:12.0" \
    icon.drawing=on \
    icon.color="$GREEN" \
    label="$glyph" \
    label.font="sketchybar-app-font:Regular:12.0" \
    label.drawing=on \
    label.color="$GREEN"
}

case "$SENDER" in
  front_app_switched|aerospace_workspace_change|forced|"")
    update_front_app
    ;;
esac
