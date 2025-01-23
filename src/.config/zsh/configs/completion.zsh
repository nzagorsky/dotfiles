# load our own completion functions
fpath=($HOME/.config/zsh/completion /usr/local/share/zsh/site-functions $fpath)

# completion; use cache if updated within 24h
autoload -Uz compinit
if [[ -n $HOME/.config/zsh/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $HOME/.config/zsh/.zcompdump;
else
  compinit -C;
fi;

# disable zsh bundled function mtools command mcd
# which causes a conflict.
compdef -d mcd
