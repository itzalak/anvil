#!/bin/bash

set -uo pipefail

echo "Enabling keychron keyboard"
echo "https://github.com/adam-savard/keyboard-function-keys-linux"
sudo cp "$HOME/foundry/dotcachy/taskfiles/scripts/keychron.service" /etc/systemd/system/
sudo systemctl enable --now keychron.service

echo "Keyboard setup is complete"
