#!/usr/bin/env bash

set -ex

export ZDOTDIR="$HOME/.config/zsh"

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

setup_fish() {
    fish -c "fisher install jethrokuan/z"
}

setup_shell_zsh() {

    curl -s https://raw.githubusercontent.com/agkozak/polyglot/master/polyglot.sh >~/.local/bin/polyglot.sh
    touch ~/.config/wget/wgetrc

    rm -rf ~/.config/zsh/plugins/zsh-syntax-highlighting/
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/plugins/zsh-syntax-highlighting

    rm -rf ~/.config/zsh/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions

    rm -rf ~/.config/zsh/plugins/zsh-history-substring-search
    git clone https://github.com/zsh-users/zsh-history-substring-search ~/.config/zsh/plugins/zsh-history-substring-search
}

setup_completions() {
    mkdir -p $ZDOTDIR/completions
    curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker >$ZDOTDIR/completions/_docker
}

pull_submodules || echo "Failed to pull submodules"
setup_dots
setup_fish
setup_completions
