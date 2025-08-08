#!/usr/bin/env zsh
autoload -Uz compinit

fpath=(/opt/homebrew/share/zsh-completions $HOME/.config/zsh/completion /usr/local/share/zsh/site-functions $fpath)
compinit -C

if type kubectl &>/dev/null; then
    source <(kubectl completion zsh)
fi
