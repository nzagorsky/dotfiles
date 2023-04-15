#!/usr/bin/env bash
set -e

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
	curl -s https://raw.githubusercontent.com/agkozak/polyglot/master/polyglot.sh >~/.local/bin/polyglot.sh
}

main() {
	pull_submodules || echo "Failed to pull submodules"
	setup_dots
	setup_shell
}

main >/dev/null
