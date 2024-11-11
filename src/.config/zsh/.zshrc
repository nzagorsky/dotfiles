#!/bin/zsh

source ~/.config/credentials/secure >/dev/null 2>&1 || true



source "$ZDOTDIR/configs/functions.zsh"
source "$ZDOTDIR/configs/keybindings.zsh"
source "$ZDOTDIR/configs/alias.zsh"
source "$ZDOTDIR/configs/prompt.zsh"
source "$ZDOTDIR/configs/options.zsh"

source "$ZDOTDIR/configs/completion.zsh"



source "$ZDOTDIR/plugins/zsh-z/zsh-z.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"


# Kukareku!
# vim:foldmethod=marker
