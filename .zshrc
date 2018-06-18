#------------------------
# Variables
#------------------------
# Basic utility.
export BROWSER="/usr/bin/opera"
export EDITOR=/usr/bin/nvim
export HISTFILE=~/.zsh_history

export PATH="$PATH:$HOME/.cargo/bin"  # RUST
export PATH="$PATH:$HOME/.nimble/bin"  # NIM
export PATH="$PATH:$HOME/.scripts"  
export PATH="$PATH:$HOME/.bin" 
export GOPATH="$HOME/go"  # GO
export PATH="$PATH:$GOPATH/bin"  # GO
export PATH="$PATH:/var/lib/snapd/snap/bin"  # Snap packages
export PYTHONPATH="$PYTHONPATH:/usr/lib/python3.6/site-packages"  # Python

# added by Miniconda3 installer
# export PATH="/home/toltenos/.conda/bin:$PATH"

export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=/opt/cuda/lib64:$LIBRARY_PATH
export CPATH=/opt/cuda/include:$CPATH

# FZF config
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude=.git ||
    find * -type f'

export FZF_DEFAULT_OPTS="--inline-info"
#------------------------
# Source
#------------------------
source ~/.credentials/secure
source ~/.zsh/antigen/antigen.zsh

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

#------------------------
# Plugins
#------------------------
antigen use oh-my-zsh

antigen bundle command-not-found
antigen bundle compleat
antigen bundle docker
antigen bundle git-extras
antigen bundle gitfast
antigen bundle pip
antigen bundle python
antigen bundle z

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# Pure prompt
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Autsuggest
antigen bundle zsh-users/zsh-history-substring-search

# Execute
antigen apply

#------------------------
# Key bindings
#------------------------
bindkey -e

# Search through history
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# Do not display modes for previously accepted lines
setopt transient_rprompt

# Ignore command duplicates.
setopt histignoredups

#------------------------
# Aliases
#------------------------
alias cp="cp -i"                          # confirm before overwriting something
alias cya='systemctl suspend'
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias grep='grep --color=tty -d skip'
alias ipac='sudo pacman -S'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -lhs --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias lla='ls -lahs --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias p='ipython'
alias rm='rm -I'
alias spac='pacman -Ss'
alias upac='sudo pacman -Syu'
alias v='nvim'
alias e='emacs -nw'


#------------------------
# Scripts
#------------------------
# ex - archive extractor. usage: ex <file>
ex ()
{
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


# Disk usage
function dutop { du --one-file-system --max-depth=2 -h * | sort -hr | head -20; }

# Tmux
t () {
    if [ -z "$1" ]
    then
        tmux -u attach -t default || tmux -u new -s default

    else
        tmux -u attach -t $1 || tmux -u new -s $1

    fi
}

# Source FZF for optional keybindings and shell improvement:
# C-r search commands
# C-t for file search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ctop () {
    docker run \
        --rm -it --name=ctop_`date +%s` \
        -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
}

torify () {
    proxychains -f ~/.config/proxychains.conf $*
}

# Kukareku.
# base16_phd
