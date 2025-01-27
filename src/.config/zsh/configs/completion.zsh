#!/usr/bin/env zsh
autoload -Uz compinit

fpath=($HOME/.config/zsh/completion /usr/local/share/zsh/site-functions $fpath)
compinit -C
