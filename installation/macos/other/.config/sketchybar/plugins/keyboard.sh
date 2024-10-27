#!/bin/bash

INPUT="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)"
LAYOUT_ID="${INPUT##*.}"

case "$LAYOUT_ID" in
"British")
  LAYOUT="EN"
  ;;
"Spanish-ISO")
  LAYOUT="ES"
  ;;
"com.apple.keylayout.ABC")
  LAYOUT="ABC"
  ;;
*)
  LAYOUT="$LAYOUT_NAME"
  ;;
esac

sketchybar --set keyboard label="$LAYOUT"
