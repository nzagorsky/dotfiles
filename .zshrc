# Source configs
for f in ~/.zsh/init/*.zsh; do source $f; done

source ~/.credentials/secure

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
