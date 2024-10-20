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
  #https://wiki.archlinux.org/title/GNOME
  #https://archlinux.org/groups/x86_64/gnome/
  #https://archlinux.org/groups/x86_64/gnome-extra/
  baobab
  cheese
  eog
  seahorse
  gnome-control-center
  gnome-disk-utility
  gnome-font-viewer
  gnome-session
  gnome-settings-daemon
  gnome-shell
  gnome-tweaks
  gvfs
  mutter
  tracker3-miners
  xdg-user-dirs-gtk

  # Theme
  qogir-gtk-theme
)

print_info "Installing gnome required packages"

for PKG in "${PKGS[@]}"; do
  print_info "Installing package: $PKG"
  yay -S "$PKG" --noconfirm --needed
done

print_info "Gnome setup is complete"
