#!/bin/bash

set -uo pipefail

# Define some colors for output
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

# Print an info message
function print_info() {
  echo
  echo -e "${GREEN}$1${RESET}"
}

print_info "Enabling keychron keyboard"
print_info "https://github.com/adam-savard/keyboard-function-keys-linux"
sudo cp "$HOME/anvil/installation/linux/extras/keychron.service" /etc/systemd/system/
sudo systemctl enable --now keychron

print_info "Installing zsa keyboard tool"
yay -S zsa-keymapp-bin --noconfirm --needed

print_info "Keyboard setup is complete"
