#!/bin/bash

case "$SENDER" in
  mouse.entered)
    sketchybar --set apple.logo background.color=$BACKGROUND_2
    ;;
  mouse.exited)
    sketchybar --set apple.logo background.color=$BACKGROUND_1
    ;;
esac

