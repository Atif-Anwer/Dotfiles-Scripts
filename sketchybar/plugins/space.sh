#!/usr/bin/env bash

source "$CONFIG_DIR/plugins/workspace_label.sh"
source "$CONFIG_DIR/plugins/workspace_focus_style.sh"

update() {
  focused="$(aerospace list-workspaces --focused 2>/dev/null || true)"
  for i in 0 {1..9}; do
    apply_workspace_display "$i" "$focused"
  done
  apply_workspace_focus_styles "$focused"
}

case "$SENDER" in
  *) update ;;
esac
