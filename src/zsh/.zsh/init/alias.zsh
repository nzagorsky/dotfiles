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