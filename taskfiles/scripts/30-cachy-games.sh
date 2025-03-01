#!/bin/bash

set -uo pipefail

PKGS=(
	cachyos-gaming-meta
	prismlauncher
)

echo "Installing packages"

for PKG in "${PKGS[@]}"; do
	echo "Installing package: $PKG"
	pacman -S "$PKG" --noconfirm --needed
done
