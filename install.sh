#!/usr/bin/env bash

set -ex

pull_submodules() {
    git submodule update --init --recursive --depth 1
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
}

setup_dots() {
    cd src
    stow -t ~ .
}

setup_shell() {
    mkdir -p ~/.local/bin/
    mkdir -p ~/.config/wget/

    curl -s https://raw.githubusercontent.com/agkozak/polyglot/master/polyglot.sh >~/.local/bin/polyglot.sh

    touch ~/.config/wget/wgetrc
}

pull_submodules || echo "Failed to pull submodules"
setup_dots
setup_shell
