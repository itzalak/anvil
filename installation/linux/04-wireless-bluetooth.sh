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

PKGS=(
  networkmanager
  # https://wiki.archlinux.org/title/Bluetooth
  bluez
  bluez-utils
  bluez-hid2hci
  bluetuith
)

print_info "Installing wireless and bluetooth related packages"

for PKG in "${PKGS[@]}"; do
  print_info "Installing package: $PKG"
  yay -S "$PKG" --noconfirm --needed
done

print_info "Setting wireless and bluetooth services"

sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now NetworkManager

print_info "Wireless and bluetooth setup is complete"
