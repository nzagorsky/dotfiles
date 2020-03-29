
export TERM=xterm-256color

# Source configs
# for f in ~/.zsh/init/*.zsh; do source $f; done

# Export all secure variables.

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Alias {{{
alias cp='cp -i'                          # confirm before overwriting something
alias cya='systemctl suspend'
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias grep='grep --color=tty -d skip'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -lhs --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias lla='ls -lahs --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias p='ipython'
alias rm='rm -I'
alias e='emacs -nw'
alias g=git
alias v=nvim
alias getmirrors='sudo pacman-mirrors -c Russia,Belarus,Ukraine,Poland,Netherlands'
# }}}
# Environment {{{
source ~/.credentials/secure

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
export FZF_DEFAULT_OPTS="--inline-info --preview 'cat {}'"

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

# }}}
# Functions {{{
ex () {
  if [ -f $1 ] ; then
  case $1 in
    *.tar.bz2)   tar xjf $1   ;;
    *.tar.gz)    tar xzf $1   ;;
    *.bz2)       bunzip2 $1   ;;
    *.rar)       unrar x $1     ;;
    *.gz)        gunzip $1    ;;
    *.tar)       tar xf $1    ;;
    *.tbz2)      tar xjf $1   ;;
    *.tgz)       tar xzf $1   ;;
    *.zip)       unzip $1     ;;
    *.Z)         uncompress $1;;
    *.7z)        7z x $1      ;;
    *)           echo "'$1' cannot be extracted via ex()" ;;
  esac
  else
  echo "'$1' is not a valid file"
  fi
}

pk () {
  if [ $1 ] ; then
  case $1 in
    tbz)       tar cjvf $2.tar.bz2 $2      ;;
    tgz)       tar czvf $2.tar.gz  $2       ;;
    tar)      tar cpvf $2.tar  $2       ;;
    bz2)    bzip $2 ;;
    gz)        gzip -c -9 -n $2 > $2.gz ;;
    zip)       zip -r $2.zip $2   ;;
    7z)        7z a $2.7z $2    ;;
    *)         echo "'$1' cannot be packed via pk()" ;;
  esac
  else
  echo "'$1' is not a valid file"
  fi
}   


# Disk usage
function dutop {
    du --max-depth=0 -h * | sort -hr | head -20;
}

# Tmux
t () {
    if [ -z "$1" ]
    then
        tmux -u attach -t default || tmux -u new -s default

    else
        tmux -u attach -t $1 || tmux -u new -s $1

    fi
}

ctop () {
    docker run \
        --rm -it --name=ctop_`date +%s` \
        -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
}

torify () {
    proxychains -f ~/.config/proxychains.conf $*
}
list_iommu () {
    shopt -s nullglob
    for g in /sys/kernel/iommu_groups/*; do
        echo "IOMMU Group ${g##*/}:"
        for d in $g/devices/*; do
            echo -e "\t$(lspci -nns ${d##*/})"
        done;
    done;
}

# v () {
#     CURRENT_FOLDER_HASH=`pwd  | md5sum | cut -f1 -d" "`
#     SESSION_NAME=nvim-session-$CURRENT_FOLDER_HASH
#     SERVERNAME=/tmp/$SESSION_NAME
#     NVIM_LISTEN_ADDRESS=$SERVERNAME

#     # Function to prevent nesting of sessions with running neovim.
#     if [[ $ABDUCO_SESSION = $SESSION_NAME ]]; then 
#         NVIM_LISTEN_ADDRESS=$SERVERNAME nvr --servername $SERVERNAME $*
#     else
#         ABDUCO_SESSION=$SESSION_NAME abduco -c $SESSION_NAME nvr --servername $SERVERNAME $* || ABDUCO_SESSION=$SESSION_NAME nvr --servername $SERVERNAME $*; ABDUCO_SESSION=$SESSION_NAME abduco -a $SESSION_NAME
#     fi
# }

# Kukareku.
#
# }}}
#
# Keyboard {{{
bindkey -e

# Search through history
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# Do not display modes for previously accepted lines
setopt transient_rprompt

# Ignore command duplicates.
setopt histignoredups
# }}}
#
# Plugins {{{ 
source ~/.zsh/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle aws
antigen bundle compleat
antigen bundle docker
antigen bundle git-extras
antigen bundle gitfast
antigen bundle httpie
antigen bundle kubectl
antigen bundle npm
antigen bundle pip
antigen bundle python
antigen bundle redis-cli
antigen bundle yarn
antigen bundle z

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# Pure prompt
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Execute
antigen apply
# }}}


# vim:foldmethod=marker:foldlevel=0
