#!/usr/bin/env bash

set -ex

pull_submodules() {
	git submodule update --init --recursive --depth 1
}

setup_dots() {
	cd src
	stow -t ~ .
}

setup_shell() {
	mkdir -p ~/.local/bin/
	mkdir -p ~/.config/wget/
	touch ~/.config/wget/wgetrc

}

pull_submodules || echo "Failed to pull submodules"
setup_dots
setup_shell
