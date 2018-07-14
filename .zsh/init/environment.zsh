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

# FZF config
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude=.git || find * -type f'
export FZF_DEFAULT_OPTS="--inline-info"

# Theming
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Source FZF for optional keybindings and shell improvement: C-r search commands; C-t for file search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
