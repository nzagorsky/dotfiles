#!/usr/bin/env bash

set -ex

pull_submodules() {
	git submodule update --init --recursive --depth 1
}

setup_dots() {
	cd src
	stow -t ~ .
}

setup_fish() {
	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
	fisher install jethrokuan/z
}

setup_shell() {
	mkdir -p ~/.local/bin/
	mkdir -p ~/.config/wget/
	touch ~/.config/wget/wgetrc
}

pull_submodules || echo "Failed to pull submodules"
setup_dots
setup_shell
setup_fish
