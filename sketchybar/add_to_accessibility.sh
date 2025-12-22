#!/bin/bash

# Script to add sketchybar to macOS Accessibility settings
# Run this script, then manually enable it in System Settings

SKETCHYBAR_PATH="/opt/homebrew/opt/sketchybar/bin/sketchybar"

if [ ! -f "$SKETCHYBAR_PATH" ]; then
    echo "Error: sketchybar not found at $SKETCHYBAR_PATH"
    exit 1
fi

echo "Adding sketchybar to Accessibility settings..."
echo "Path: $SKETCHYBAR_PATH"
echo ""
echo "Method 1: Using tccutil (requires admin password)"
echo "Run: sudo tccutil reset Accessibility com.koekeishiya.sketchybar"
echo ""
echo "Method 2: Manual addition"
echo "1. Open System Settings > Privacy & Security > Accessibility"
echo "2. Click the + button"
echo "3. Navigate to: $SKETCHYBAR_PATH"
echo "4. Select 'sketchybar' and click 'Open'"
echo "5. Make sure the checkbox next to sketchybar is enabled"
echo ""

# Try to open the Accessibility settings pane
open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"

echo "System Settings should now be open. Please follow Method 2 above."
echo ""
echo "After adding, restart sketchybar with: brew services restart sketchybar"

