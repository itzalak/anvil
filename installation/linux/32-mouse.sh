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

print_info "Installing logiops and required packages"
sudo pacman -S --noconfirm cmake libevdev libconfig pkgconf

LOGIOPS_DIR="$HOME/anvil/depository/logiops"
mkdir -p "$LOGIOPS_DIR"

print_info "Cloning logiops repository"
git clone https://github.com/PixlOne/logiops.git "$LOGIOPS_DIR"

BUILD_DIR="$LOGIOPS_DIR/build"

print_info "Building logiops"
mkdir -p "$BUILD_DIR"
(cd "$BUILD_DIR" && cmake .. && make)
(cd "$BUILD_DIR" && sudo make install)

print_info "Starting logid service"
sudo systemctl enable --now logid

print_info "Logiops setup complete"
