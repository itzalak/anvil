#!/bin/bash

set -uo pipefail

PKGS=(
	# Lua
	lua
	luarocks
	stylua

	# IDE
	intellij-idea-community-edition
	pycharm-community-edition

	# Misc
	ktlint
	git-extras
	tree
	cargo
	npm
	jq
	shellcheck
	yq
	lazygit
	gron
)

echo "Installing required packages for development"

for PKG in "${PKGS[@]}"; do
	echo "Installing package: $PKG"
	paru -S "$PKG" --noconfirm --needed
done

echo "Development setup is complete"
