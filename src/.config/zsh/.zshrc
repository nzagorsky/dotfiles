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

eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"
# Kukareku!
# vim:foldmethod=marker
