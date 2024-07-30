#!/bin/bash

set -uo pipefail

# Define some colors for output
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

# Print an info message
function print_info() {
  echo -e "${GREEN}$1${RESET}"
}

# Extra packages - optional or temporary

PKGS=(
  skypeforlinux-bin
)

for PKG in "${PKGS[@]}"; do
  echo
  print_info "INSTALLING PACKAGE: $PKG"
  yay -S "$PKG" --noconfirm --needed
done

echo
print_info "Default packages installed successfully"
echo
