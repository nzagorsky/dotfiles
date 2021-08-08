#!/bin/zsh

# Environment {{{
source ~/.config/credentials/secure > /dev/null 2>&1 || true

export BROWSER=brave
export EDITOR=nvim
export TERM=xterm-256color

# Go
export GOPATH="$HOME/.local/include/go"
export PATH="$PATH:$GOPATH/bin"

# Binary paths
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/include/cargo/bin"

# FZF config
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude=.git || fdfind --type f --hidden --exclude=.git || find * -type f'
export FZF_DEFAULT_OPTS="--inline-info --preview 'bat {}'"

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket


if command -v brew > /dev/null 2>&1 
then
    export PATH="/usr/local/opt/python/libexec/bin:$PATH"
    export PATH="$PATH:$HOME/Library/Python/3.9/bin"
    export PATH=$(brew --prefix openvpn)/sbin:$PATH
fi

# }}}
# Options {{{
bindkey -e
setopt AUTO_CD
setopt NO_CASE_GLOB

# History settings
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
SAVEHIST=5000
HISTSIZE=2000
HISTFILE=$ZDOTDIR/history

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
# }}}
# Completion setup {{{
zstyle ':completion:*' menu select
# Case insensitive
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

# partial completion suggestions
zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix 

# Enable completion module
autoload -U compinit && compinit
# }}}

# Functions {{{
function t {
    launch_param=$(pidof systemd > /dev/null 2>&1 && echo "systemd-run --scope --user" || echo "")

    if [ -z "$argv" ]; then
        tmux -u attach -t default || zsh -c "$launch_param tmux -u new -s default 2> /dev/null"
    else
        tmux -u attach -t $@ || zsh -c "$launch_param tmux -u new -s $@ 2> /dev/null"
    fi
}

function dutop  {
    du --max-depth=0 -h * | sort -hr | head -20;
}

function bluetooth_codecs {
    pactl list | grep a2dp_codec
}

function activate_venv {
    . venv/bin/activate
    pip3 install black isort neovim ipython django-stubs
}

# }}}
# Alias setup {{{
alias cp='cp -i'                          # confirm before overwriting something
alias cya='systemctl suspend'
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias grep='grep --color=tty -d skip'
alias la='exa -la'
alias ll='exa -lhs size'
alias lll='exa -lhs size'
alias lla='exa -lahs size'
alias ls='exa'
alias p='ipython'
alias k='kubectl --log-file $HOME/.cache/kube/log --cache-dir $HOME/.cache/kube/'
alias e='emacs -nw'
alias g=git
alias v=nvim
alias reset_shell='env -i HOME="$HOME" zsh -l'

alias getmirrors='sudo bash -c "reflector --sort rate -n 10 --threads 30 -a 3 > /etc/pacman.d/mirrorlist"'
alias gst="git status"
alias gdiff="git diff"
alias python=python3
alias rclone="rclone -P"


# Columns for piping
# Example: cat test.txt | c2 | xargs echo
alias c1="awk '{print \$1}'"
alias c2="awk '{print \$2}'"
alias c3="awk '{print \$3}'"
alias c4="awk '{print \$4}'"
alias c5="awk '{print \$5}'"
alias c6="awk '{print \$6}'"
alias c7="awk '{print \$7}'"
alias c8="awk '{print \$8}'"
alias c9="awk '{print \$9}'"


# Plugins {{{
source $ZDOTDIR/plugins/zsh-z/zsh-z.plugin.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

POLYGLOT_PROMPT_DIRTRIM=2
. ~/.local/bin/polyglot.sh
# }}}

# Kukareku.
# vim:foldmethod=marker