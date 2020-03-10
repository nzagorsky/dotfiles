bindkey -e

# Search through history
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# Do not display modes for previously accepted lines
setopt transient_rprompt

# Ignore command duplicates.
setopt histignoredups

