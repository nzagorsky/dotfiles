# vim:foldmethod=marker:foldlevel=0
# Alias {{{
alias cp='cp -i'                          # confirm before overwriting something
alias g='git'                          # confirm before overwriting something
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
alias e='emacs -nw'
alias k='kubectl'
alias rng='ranger'

alias ping='grc --colour=auto ping'
alias make='grc --colour=auto make'
alias diff='grc --colour=auto diff'

alias scw='docker run -it --rm --volume=$HOME/.scwrc:/.scwrc scaleway/cli'
# }}}
# Environment {{{
set -x BROWSER "/usr/bin/chromium"
set -x EDITOR /usr/bin/nvim
set -x PATH $PATH $HOME/.local/bin

set -x ESHELL $SHELL

# Nim
set -x NIMPATH "~/.nimble"
set -x PATH $PATH $NIMPATH/bin
set -x PATH $PATH $HOME/.nimble/bin  # NIM

# Utils
set -x PATH $PATH $HOME/.scripts  
set -x PATH $PATH $HOME/.bin 

# Go
set -x GOPATH $HOME/.go
set -x PATH $PATH $GOPATH/bin


# FZF config
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude=.git || find * -type f'
set -x FZF_DEFAULT_OPTS "--inline-info"
# }}}
# Functions {{{
# ex () {
#   if [ -f $argv[1] ] ; then
#   case $argv[1] in
#     *.tar.bz2)   tar xjf $argv[1]                                ;;
#     *.tar.gz)    tar xzf $argv[1]                                ;;
#     *.bz2)       bunzip2 $argv[1]                                ;;
#     *.rar)       unrar x $argv[1]                                ;;
#     *.gz)        gunzip $argv[1]                                 ;;
#     *.tar)       tar xf $argv[1]                                 ;;
#     *.tbz2)      tar xjf $argv[1]                                ;;
#     *.tgz)       tar xzf $argv[1]                                ;;
#     *.zip)       unzip $argv[1]                                  ;;
#     *.Z)         uncompress $argv[1]                             ;;
#     *.7z)        7z x $argv[1]                                   ;;
#     *)           echo "'$argv[1]' cannot be extracted via ex()"  ;;
#   esac
#   else
#   echo "'$argv[1]' is not a valid file"
#   fi
# }

# pk () {
#   if [ $argv[1] ] ; then
#   case $argv[1] in
#     tbz)       tar cjvf $argv[2].tar.bz2 $argv[2]            ;;
#     tgz)       tar czvf $argv[2].tar.gz  $argv[2]            ;;
#     tar)       tar cpvf $argv[2].tar  $argv[2]               ;;
#     bz2)       bzip $argv[2]                                 ;;
#     gz)        gzip -c -9 -n $argv[2] > $argv[2].gz          ;;
#     zip)       zip -r $argv[2].zip $argv[2]                  ;;
#     7z)        7z a $argv[2].7z $argv[2]                     ;;
#     *)         echo "'$argv[1]' cannot be packed via pk()"   ;;
#   esac
#   else
#   echo "'$argv[1]' is not a valid file"
#   fi
# }   


# Disk usage
function dutop 
    du --one-file-system --max-depth=2 -h $argv[1] | sort -hr | head -20;
end

# Tmux
function t
    if $argv[1]
    then
        tmux -u attach -t default; or tmux -u new -s default

    else
        tmux -u attach -t $argv[1]; or tmux -u new -s $argv[1]
    end
end

function ctop
    docker run \
        --rm -it --name=ctop_(date +%s) \
        -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest 
end

function torify
    proxychains -f ~/.config/proxychains.conf $argv
end

function v 
    if test -e Session.vim
        nvim $argv -S
    else
        nvim $argv
    end
end
# }}}
# Fisher init {{{
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
# }}}
# Export all secure variables.
source ~/.credentials/secure
