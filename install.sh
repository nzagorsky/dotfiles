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

}

install_tpm() {
    if cd ~/.config/tmux/plugins/tpm; then git pull; else git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm; fi
}

main() {
	pull_submodules || echo "Failed to pull submodules"
	setup_dots
	setup_shell
    install_tpm
}

main >/dev/null
