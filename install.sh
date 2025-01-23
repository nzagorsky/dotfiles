#!/usr/bin/env bash

set -ex

pull_submodules() {
    git submodule update --init --recursive --depth 1
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
}

setup_dots() {
    cd src
    stow -t ~ .

    mkdir -p ~/.local/bin/
    mkdir -p ~/.config/wget/
}

setup_shell_zsh() {
    curl -s https://raw.githubusercontent.com/agkozak/polyglot/master/polyglot.sh >~/.local/bin/polyglot.sh
    touch ~/.config/wget/wgetrc

    rm -rf ~/.config/zsh/plugins/zsh-syntax-highlighting/
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/plugins/zsh-syntax-highlighting

    rm -rf ~/.config/zsh/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions

    rm -rf ~/.config/zsh/plugins/zsh-autocomplete
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ~/.config/zsh/plugins/zsh-autocomplete
}

setup_completions() {
    mkdir -p $HOME/.config/zsh/completion
    curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker >$HOME/.config/zsh/completion/_docker
}

pull_submodules || echo "Failed to pull submodules"
setup_dots
setup_completions
setup_shell_zsh
