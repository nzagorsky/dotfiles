#!/bin/zsh
source $HOME/.config/secure || true
source "$HOME/.config/zsh/plugins/zsh-defer/zsh-defer.plugin.zsh"

source "$HOME/.config/zsh/configs/functions.zsh"
source "$HOME/.config/zsh/configs/keybindings.zsh"
source "$HOME/.config/zsh/configs/alias.zsh"
source "$HOME/.config/zsh/configs/prompt.zsh"
source "$HOME/.config/zsh/configs/options.zsh"

zsh-defer source "$HOME/.config/zsh/configs/completion.zsh"
zsh-defer source "$HOME/.config/zsh/plugins/zsh-z/zsh-z.plugin.zsh"
zsh-defer source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if command -v mise &>/dev/null; then
    zsh-defer eval "$(mise activate zsh)"
fi

# Debug startup speed with `watch -n 0.5 "time /bin/zsh -i -c exit"`
# Kukareku!
