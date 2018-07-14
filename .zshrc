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

export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=/opt/cuda/lib64:$LIBRARY_PATH
export CPATH=/opt/cuda/include:$CPATH
export QT_LOGGING_RULES="qt5ct.debug=false"  # Silence QT errors

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
antigen bundle kubectl
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

# Source everything.
for f in ~/.zsh/init/*.zsh; do source $f; done

# Source FZF for optional keybindings and shell improvement:
# C-r search commands
# C-t for file search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
