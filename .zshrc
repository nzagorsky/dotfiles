export TERM=xterm-256color

# Source configs
for f in ~/.zsh/init/*.zsh; do source $f; done

# Export all secure variables.
source ~/.credentials/secure

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

xset r rate 280 40  # Speedup keyboard
