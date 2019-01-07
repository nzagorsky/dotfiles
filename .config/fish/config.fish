# vim:foldmethod=marker:foldlevel=0
# Initial {{{
source ~/.config/fish/prompt.fish
# }}}
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
alias gst='git status'

alias ping='grc --colour=auto ping'
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
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude=.git; or find * -type f'
set -x FZF_DEFAULT_OPTS "--inline-info"
# }}}
# Functions {{{
function ex
    if set -q argv[1]
        switch $argv[1]
        case '*.tar.bz2';   tar xjf $argv[1]                                
        case '*.tar.gz';    tar xzf $argv[1]                                
        case '*.bz2';       bunzip2 $argv[1]                                
        case '*.rar';       unrar x $argv[1]                                
        case '*.gz';        gunzip $argv[1]                                 
        case '*.tar';       tar xf $argv[1]                                 
        case '*.tbz2';      tar xjf $argv[1]                                
        case '*.tgz';       tar xzf $argv[1]                                
        case '*.zip';       unzip $argv[1]                                  
        case '*.Z';         uncompress $argv[1]                             
        case '*.7z';        7z x $argv[1]                                   
        case '*';           echo "'$argv[1]' cannot be extracted via ex()"  
    end
else
    echo "You no unpack this boi"
end
end

function pk
    if set -q argv[1]
        switch $argv[1]
        case tbz;       tar cjvf $argv[2].tar.bz2 $argv[2]            
        case tgz;       tar czvf $argv[2].tar.gz  $argv[2]            
        case tar;       tar cpvf $argv[2].tar  $argv[2]               
        case bz2;       bzip $argv[2]                                 
        case gz;        gzip -c -9 -n $argv[2] > $argv[2].gz          
        case zip;       zip -r $argv[2].zip $argv[2]                  
        case 7z;        7z a $argv[2].7z $argv[2]                     
        case *;         echo "'$argv[1]' cannot be packed via pk()"   
    end
else
    echo "You no pack this boi"
end
end

function fish_greeting
end

function dutop
    du --one-file-system --max-depth=2 -h $argv[1] | sort -hr | head -20;
end

# Tmux
function t
    if set -q $argv[1]
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
