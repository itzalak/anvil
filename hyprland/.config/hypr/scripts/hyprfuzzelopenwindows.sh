#!/bin/bash

openwindows=$(
  hyprctl clients -j |
    jq -r '.[] | "[\(.workspace.id)] [\(.class)] \(.title) \(.address)"' |
    sort |
    rofi -dmenu |
    awk '{print $NF}'
)

if [[ -z $openwindows ]]; then
  exit
fi

# Focus on the selected window
hyprctl dispatch focuswindow "address:${openwindows}"
