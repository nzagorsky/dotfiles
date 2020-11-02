# Environment {{{
export TERM=xterm-256color
source ~/.credentials/secure

# Default config
export BROWSER="/usr/bin/google-chrome-stable"
export EDITOR=nvim
export HISTFILE=~/.zsh_history

# Utils
export PATH="$PATH:$HOME/.scripts"  

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
# Functions {{{

# Overwrite fish greeting
function fish_greeting
end

# Disk usage
function dutop 
    du --max-depth=0 -h * | sort -hr | head -20;
end


# Tmux
function t
    if [ -z "$argv" ]
        tmux -u attach -t default || tmux -u new -s default

    else
        tmux -u attach -t $argv || tmux -u new -s $argv

    end
end

function ctop
    docker run \
        --rm -it --name=ctop_`date +%s` \
        -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
end


function torify
    proxychains -f ~/.config/proxychains.conf $argv
end

function add_to_group
    sudo gpasswd -a $USER $argv[1]
end

function b
    set no_search_commands "scan" "devices"

    if contains $argv[1] $no_search_commands
        bluetoothctl -- $argv

    else

        set DEVICE (bluetoothctl -- devices | grep -i $argv[2])
        echo ">> Found device: $DEVICE"
        set MAC_ADDRESS (echo $DEVICE | cut -d' ' -f2)
        bluetoothctl -- $argv[1] $MAC_ADDRESS
    end
end


# }}}
# Alias {{{
alias cp='cp -i'                          # confirm before overwriting something
alias cya='systemctl suspend'
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias grep='grep --color=tty -d skip'
alias cat=bat
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

# Kukareku.
# vim:foldmethod=marker:foldlevel=0
