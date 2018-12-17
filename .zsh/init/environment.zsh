export BROWSER="/usr/bin/opera"
export EDITOR=/usr/bin/nvim
export HISTFILE=~/.zsh_history

# Nim
export PATH="$PATH:$HOME/.nimble/bin"  # NIM

# Utils
export PATH="$PATH:$HOME/.scripts"  
export PATH="$PATH:$HOME/.bin" 

# Go
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

# Snaps
export PATH="$PATH:/var/lib/snapd/snap/bin"  # Snap packages

# Nim
export NIMPATH="~/.nimble"
export PATH="$PATH:$NIMPATH/bin"

# Python
# export PYTHONPATH="$PYTHONPATH:/usr/lib/python3.7/site-packages"  # Python

# FZF config
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude=.git || find * -type f'
export FZF_DEFAULT_OPTS="--inline-info"

# Source FZF for optional keybindings and shell improvement: C-r search commands; C-t for file search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
