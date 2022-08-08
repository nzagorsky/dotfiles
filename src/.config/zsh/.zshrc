#!/bin/zsh

# Environment {{{
source ~/.config/credentials/secure > /dev/null 2>&1 || true

export BROWSER=brave
export EDITOR=nvim
export TERM=xterm-256color
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Ansible settings
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_PIPELINING=True
export ANSIBLE_HOST_KEY_CHECKING=False

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

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-backward

# }}}
# Completion setup {{{
# https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit && compinit
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
fi

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


function tt {
    t $(echo $ITERM_SESSION_ID | cut -d : -f 1)
}

function kconfig {
    export KUBECONFIG="$HOME/.config/kube/$@"
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

function macnst (){
    netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|"
}

function macnotify() {
    # Usage: 
    # $ macnotify Title "Long notification text"

    osascript -e 'display notification "'$2'" with title "'$1'"'
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
alias e='emacs -nw'
alias g=git
alias v=nvim
alias reset_shell='env -i HOME="$HOME" zsh -l'

alias gdiff="git diff"
alias getmirrors='sudo bash -c "reflector --sort rate -n 10 --threads 30 -a 3 > /etc/pacman.d/mirrorlist"'
alias git_search_all="g log --all -p --source -G"
alias gpull="git pull"
alias gst="git status"
alias mac_flushdns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
alias macdns="scutil --dns | egrep -i '(domain|nameserver)'"
alias maclaunchrebuild="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias macncdu="ncdu --exclude /System/Volumes/Data -x /"
alias manage="nvim ~/Documents/notes/tasks.md"
alias python=python3
alias rclone="rclone -P"
alias telepresence_reconnect="telepresence quit && sleep 2 && telepresence connect"
alias tf="terraform"

# K8s
alias k='kubectl'
alias kd='kubectl describe'
alias kg='kubectl get'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias ke='kubectl exec'
alias kgn='kubectl get namespaces'

alias kda='kubectl describe --all-namespaces'
alias kga='kubectl get --all-namespaces'

alias kgp='kubectl get pod'
alias kdp='kubectl describe pod'
alias kgd='kubectl get deployment'
alias kdd='kubectl describe deployment'
alias kgs='kubectl get service'

alias kgpa='kubectl get pod --all-namespaces'
alias kgda='kubectl get deployment --all-namespaces'
alias kgsa='kubectl get svc --all-namespaces'

alias kcuc='kubectl config use-context'
alias kcur='kubectl config current-context'


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

alias ...="../../"
alias ....="../../../"
alias .....="../../../../"


# Plugins {{{
source $ZDOTDIR/plugins/zsh-z/zsh-z.plugin.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

POLYGLOT_PROMPT_DIRTRIM=2
. ~/.local/bin/polyglot.sh
# }}}

# Kukareku.
# vim:foldmethod=marker
