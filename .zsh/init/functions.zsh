ex () {
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

pk () {
  if [ $1 ] ; then
  case $1 in
    tbz)       tar cjvf $2.tar.bz2 $2      ;;
    tgz)       tar czvf $2.tar.gz  $2       ;;
    tar)      tar cpvf $2.tar  $2       ;;
    bz2)    bzip $2 ;;
    gz)        gzip -c -9 -n $2 > $2.gz ;;
    zip)       zip -r $2.zip $2   ;;
    7z)        7z a $2.7z $2    ;;
    *)         echo "'$1' cannot be packed via pk()" ;;
  esac
  else
  echo "'$1' is not a valid file"
  fi
}   


# Disk usage
function dutop {
    du --one-file-system --max-depth=2 -h $1 | sort -hr | head -20;
}

# Tmux
# t () {
#     if [ -z "$1" ]
#     then
#         tmux -u attach -t default || tmux -u new -s default

#     else
#         tmux -u attach -t $1 || tmux -u new -s $1

#     fi
# }

ctop () {
    docker run \
        --rm -it --name=ctop_`date +%s` \
        -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
}

torify () {
    proxychains -f ~/.config/proxychains.conf $*
}

v () {
    CURRENT_FOLDER_HASH=`pwd  | md5sum | cut -f1 -d" "`
    SESSION_NAME="nvim-session-$CURRENT_FOLDER_HASH"
    SERVERNAME=/tmp/$SESSION_NAME
    NVIM_LISTEN_ADDRESS=$SERVERNAME

    # Function to prevent nesting of sessions with running neovim.
    if [ "$ABDUCO_SESSION" = $SESSION_NAME]; then 
        nvr --servername $SERVERNAME $*
    else
        ABDUCO_SESSION=$SESSION_NAME abduco -c $SESSION_NAME nvr --servername $SERVERNAME $* ||
            nvr --servername $SERVERNAME $*; abduco -a $SESSION_NAME
    fi
}

# Kukareku.
