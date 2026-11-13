#!/usr/bin/env bash

# Workspaces per aerospace monitor (respects aerospace.toml assignments at runtime).

aerospace_monitors_ordered() {
  aerospace list-monitors 2>/dev/null | awk -F'|' '{gsub(/^ *| *$/, "", $1); gsub(/^ *| *$/, "", $2); print $1 "\t" $2}'
}

workspaces_on_aerospace_monitor() {
  local amid="$1"
  aerospace list-workspaces --monitor "$amid" 2>/dev/null
}

sort_workspace_nums() {
  sort -n
}
