#!/bin/bash
# Debug helper to see what app names aerospace reports and their icon mappings

echo "=== Current Aerospace Windows ==="
echo ""

aerospace list-windows --all | while IFS='|' read -r workspace app_name window_title; do
    # Trim whitespace
    app_name=$(echo "$app_name" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    workspace=$(echo "$workspace" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    # Get the icon for this app
    icon=$(/Users/atif/.config/sketchybar/plugins/icon_map.sh "$app_name")
    
    printf "Workspace: %-2s | App: %-30s | Icon: %s\n" "$workspace" "$app_name" "$icon"
done

echo ""
echo "=== Test specific app name ==="
echo "Usage: $0 \"App Name\""
if [ -n "$1" ]; then
    icon=$(/Users/atif/.config/sketchybar/plugins/icon_map.sh "$1")
    echo "App: $1"
    echo "Icon: $icon"
fi

