#!/bin/bash

if pgrep -x "hyprsunset" >/dev/null; then
  killall hyprsunset
else
  hyprsunset -t 4500 &
fi
