#!/bin/zsh
source "$HOME/.config/credentials/secure" >/dev/null 2>&1 || true

source "$HOME/.config/zsh/plugins/zsh-z/zsh-z.plugin.zsh"
source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source "$HOME/.config/zsh/configs/functions.zsh"
source "$HOME/.config/zsh/configs/keybindings.zsh"
source "$HOME/.config/zsh/configs/alias.zsh"
source "$HOME/.config/zsh/configs/prompt.zsh"
source "$HOME/.config/zsh/configs/options.zsh"
source "$HOME/.config/zsh/configs/completion.zsh"


if type direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

if type mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi


# Kukareku!
# vim:foldmethod=marker
