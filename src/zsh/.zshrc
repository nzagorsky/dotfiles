#!/bin/zsh

# Environment {{{
source ~/.credentials/secure

# Default config
export BROWSER="/usr/bin/google-chrome-stable"
export EDITOR=nvim
export TERM=xterm-256color

# Utils
export PATH="$PATH:$HOME/.scripts"  

# Pulumi
export PATH="$PATH:$HOME/.pulumi/bin"

# Go
export GOPATH="$HOME/code/go"

# FZF config
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude=.git || fdfind --type f --hidden --exclude=.git || find * -type f'
export FZF_DEFAULT_OPTS="--inline-info --preview 'bat {}'"

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# Binary paths
export PATH="$PATH:$HOME/.local/bin"
export PATH="/snap/bin:$PATH"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.emacs.d/bin"

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
HISTFILE=$HOME/.zsh/history

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
# Custom prompt (disabled) {{{
# PROMPT='%(?.%F{green}.%F{red}?%?)%f %B%F{240}%1~%f%b %# '
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
# RPROMPT=\$vcs_info_msg_0_
# zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
# zstyle ':vcs_info:*' enable git
# }}}
# Functions {{{
function t {
    launch_param=$(pidof systemd > /dev/null && echo "systemd-run --scope --user" || echo "")

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
# }}}
# Alias setup {{{
alias cp='cp -i'                          # confirm before overwriting something
alias cya='systemctl suspend'
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias grep='grep --color=tty -d skip'
alias la='exa -la --group-directories-first --color=auto -F'
alias ll='exa -lhs --group-directories-first --color=auto -F'
alias lla='exa -lahs --group-directories-first --color=auto -F'
alias ls='exa --color=auto -F'
alias p='ipython'
alias k='kubectl'
alias rm='rm -I'
alias e='emacs -nw'
alias g=git
alias v=nvim

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

# }}}
# Startup of sway {{{
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
    export GTK_THEME=deepin-dark
    exec sway
fi
# }}}

# Plugins {{{
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-z/zsh-z.plugin.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 

POLYGLOT_PROMPT_DIRTRIM=5
. ~/.local/bin/polyglot.sh
# }}}

# Kukareku.
# vim:foldmethod=marker
