#!/bin/sh

#        __     ____            ____
#   ____/ /__  / __/___ ___  __/ / /_   ____ _____  ____
#  / __  / _ \/ /_/ __ `/ / / / / __/  / __ `/ __ \/ __ \
# / /_/ /  __/ __/ /_/ / /_/ / / /_   / /_/ / /_/ / /_/ /
# \__,_/\___/_/  \__,_/\__,_/_/\__/   \__,_/ .___/ .___/
#                                         /_/   /_/

# Define the default app for opening a file type

FILETYPE=$(xdg-mime query filetype $1)
APP=$(fd -c always --search-path /usr/share -e .desktop --exec basename | rofi -dmenu -i -p "Default to")
xdg-mime default "$APP" "$FILETYPE"
echo "$APP set as default application to open $FILETYPE"
