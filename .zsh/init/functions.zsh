# ex - archive extractor. usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# Disk usage
function dutop {
    du --one-file-system --max-depth=2 -h / | sort -hr | head -20;
}

# Tmux
t () {
    if [ -z "$1" ]
    then
        tmux -u attach -t default || tmux -u new -s default

    else
        tmux -u attach -t $1 || tmux -u new -s $1

    fi
}

ctop () {
    docker run \
        --rm -it --name=ctop_`date +%s` \
        -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
}

torify () {
    proxychains -f ~/.config/proxychains.conf $*
}

# Kukareku.
