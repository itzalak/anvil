#!/bin/bash

set -uo pipefail

PKGS=(
	# AMD
	amdgpu_top
	# Other
	zsa-keymapp-bin
)

echo "Installing paru packages"

for PKG in "${PKGS[@]}"; do
	echo "Installing package: $PKG"
	paru -S "$PKG" --noconfirm --needed
done
