#!/bin/bash

set -e

# archinstall extra package

PKGS=(
  base-devel
  git
  neovim
  bluez
  bluez-utils
  bluez-hid2hci
  firefox
  zsh
  wezterm
  networkmanager
)

for PKG in "${PKGS[@]}"; do
  echo "INSTALLING PACKAGE: $PKG"
  sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Installation is done"
echo
