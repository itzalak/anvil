#!/bin/bash

BREW=$(which brew)

if ! [ "$BREW" ]; then
  echo "Homebrew not found! Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is installed"
fi

exit 0
