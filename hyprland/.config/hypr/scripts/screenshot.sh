#!/bin/bash

FILENAME="$HOME/Pictures/screenshot_$(date +%d%m%Y%H%M%S).png"

selectedarea() {
  grim -g "$(slurp)" "$FILENAME"
}

activescreen() {
  grim -o "$(hyprctl monitors all -j | jq -r '.[] | select(.focused) | .name')" "$FILENAME"
}

activewindow() {
  grim -g "$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" "$FILENAME"
}

clipboard() {
  grim -g "$(slurp)" "$FILENAME"
  wl-copy <"$FILENAME"
}

notify() {
  if [ -e "$FILENAME" ]; then
    notify-send "Screenshot successful" "Path: $FILENAME"
  else
    notify-send -u critical -t 6000 "Screenshot failed to generate file!"
  fi
}

area="Screenshot selected area"
screen="Screenshot active screen"
window="Screenshot active window"
copytoclipboard="Screenshot area to clipboard"

options="$area\n$window\n$screen\n$copytoclipboard"

choice=$(echo -e "$options" | rofi -dmenu)

case $choice in
"$area")
  selectedarea
  notify
  ;;
"$screen")
  activescreen
  notify
  ;;
"$window")
  activewindow
  notify
  ;;
"$copytoclipboard")
  clipboard
  notify
  ;;
esac
