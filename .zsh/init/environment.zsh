# Default config
export BROWSER="/usr/bin/google-chrome-unstable"
export EDITOR=nvim
export HISTFILE=~/.zsh_history

# Utils
export PATH="$PATH:$HOME/.scripts"  

# Go
export GOPATH="$HOME/.go"

# FZF config
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude=.git || find * -type f'
export FZF_DEFAULT_OPTS="--inline-info"

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# Source FZF for optional keybindings and shell improvement: C-r search commands; C-t for file search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Binary paths
export PATH="$PATH:$HOME/.local/bin"
export PATH="/snap/bin:$PATH"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$GOPATH/bin"

# TODO move to separate modules file
# Autocompletion
zmodload zsh/zpty
