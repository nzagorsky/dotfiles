#!/usr/bin/env bash

set -e

require_cmd() {
    command -v "$1" >/dev/null 2>&1 || {
        echo "Missing required command: $1" >&2
        exit 1
    }
}

clone_or_update() {
    local repo="$1"
    local dest="$2"
    local depth="${3:-1}"

    if [[ -d "$dest/.git" ]]; then
        git -C "$dest" fetch --depth "$depth" origin
        git -C "$dest" reset --hard "origin/$(git -C "$dest" rev-parse --abbrev-ref HEAD)"
        return 0
    fi

    rm -rf "$dest"
    git clone --depth "$depth" "$repo" "$dest"
}

pull_submodules() {
    git submodule update --init --recursive --depth 1
    clone_or_update https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
}

setup_dots() {
    cd src
    stow -t ~ .

    mkdir -p ~/.local/bin/
    mkdir -p ~/.config/wget/
}

setup_shell_zsh() {
    curl -fSL https://raw.githubusercontent.com/agkozak/polyglot/master/polyglot.sh >~/.local/bin/polyglot.sh
    touch ~/.config/wget/wgetrc

    clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/plugins/zsh-syntax-highlighting
    clone_or_update https://github.com/romkatv/zsh-defer.git ~/.config/zsh/plugins/zsh-defer
    clone_or_update https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions
    clone_or_update https://github.com/marlonrichert/zsh-autocomplete.git ~/.config/zsh/plugins/zsh-autocomplete
}

setup_completions() {
    mkdir -p $HOME/.config/zsh/completion
    curl -fSL https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker >$HOME/.config/zsh/completion/_docker
}

require_cmd git
require_cmd curl
require_cmd stow

pull_submodules || echo "Failed to pull submodules"
setup_dots
setup_completions
setup_shell_zsh
