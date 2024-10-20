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
  # Run with nvidia by setting "prime-run %command%"
  steam
  # https://wiki.archlinux.org/title/Minecraft
  minecraft-launcher
  # https://wiki.archlinux.org/title/NVIDIA
  lib32-nvidia-utils
  nvidia-settings
  nvidia-prime
)

print_info "Installing games"

for PKG in "${PKGS[@]}"; do
  print_info "Installing package: $PKG"
  yay -S "$PKG" --noconfirm --needed
done

print_info "(!) to run minecraft with nvidia set the nvidiarun.sh script in the launcher"
print_info "(!) to run steam with nvidia set prime-run %command% in steam"

print_info "games installation complete"
