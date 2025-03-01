#!/bin/bash

set -uo pipefail

#// TODO: Under resivion

PKGS=(
	# AMD
	xf86-video-amdgpu
	mesa-utils
	vulkan-radeon
	# Nvidia
	dkms
	nvidia-open-dkms
	nvidia-utils
	libvdpau
	libva-nvidia-driver
	egl-wayland
)

echo "Installing packages"

for PKG in "${PKGS[@]}"; do
	echo "Installing package: $PKG"
	sudo pacman -S "$PKG" --noconfirm --needed
done

YAYPKGS=(
	# AMD
	amdgpu_top
	# Asus
	# https://wiki.archlinux.org/title/Asusctl
	# https://asus-linux.org/manual/asusctl-manual/
	# https://asus-linux.org/manual/supergfxctl-manual/
	# supergfxctl
	rog-control-center
	asusctl
)

echo "Installing yay packages"

for YPKG in "${YAYPKGS[@]}"; do
	echo "Installing package: $YPKG"
	yay -S "$YPKG" --noconfirm --needed
done

echo "Setting asus services"

sudo systemctl enable --now asusd.service
# sudo systemctl enable --now supergfxd.service
