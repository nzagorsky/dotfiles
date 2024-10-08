#!/bin/zsh

source ~/.config/credentials/secure >/dev/null 2>&1 || true

fpath=($ZDOTDIR/completions $fpath)
autoload -Uz compinit && compinit -i

bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down
# history-beginning-search-backward

function t {
    launch_param=$(pidof systemd >/dev/null 2>&1 && echo "systemd-run --scope --user" || echo "")

    if [ -z "$argv" ]; then
        tmux -u attach -t default || zsh -c "$launch_param tmux -u new -s default 2> /dev/null"
    else
        tmux -u attach -t $@ || zsh -c "$launch_param tmux -u new -s $@ 2> /dev/null"
    fi
}

function k_force_delete_ns {
    NAMESPACE=$1
    kubectl proxy &
    kubectl get namespace $NAMESPACE -o json | jq '.spec = {"finalizers":[]}' >temp.json
    curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
    rm temp.json
}

extract() {
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) rar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function tt {
    t $(echo $ITERM_SESSION_ID | cut -d : -f 1)
}

function kconfig {
    export KUBECONFIG="$HOME/.config/kube/$@"
}

function kubuild {
    kustomize build --enable-alpha-plugins $@
}

function kuapply {
    kustomize build --enable-alpha-plugins $@ | kubectl apply -f -
}

function kudelete {
    kustomize build --enable-alpha-plugins $@ | kubectl delete -f -
}

function fancy-ctrl-z() {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line -w
    else
        zle push-input -w
        zle clear-screen -w
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

function macnst() {
    netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|"
}

function macnotify() {
    # Usage:
    # $ macnotify Title "Long notification text"

    osascript -e 'display notification "'$2'" with title "'$1'"'
}

# }}}
# Alias setup {{{
alias cp='cp -i' # confirm before overwriting something
alias cya='systemctl suspend'
alias senv='export $(xargs < .env)'
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias grep='grep --color=tty -d skip'
alias la='eza -la'
alias ll='eza -lhs size'
alias lll='eza -lhs size'
alias lla='eza -lahs size'
alias ls='eza'
alias p='ipython'
alias e='emacs -nw'
alias g=git
alias v=nvim
alias reset_shell='env -i HOME="$HOME" zsh -l'
alias lofimpv='mpv --no-video "https://www.youtube.com/watch?v=jfKfPfyJRdk"'
alias wowmpv='mpv --no-video "https://www.youtube.com/Meisio/live"'

alias gdiff="git diff"
alias git_search_all="g log --all -p --source -G"
alias gpull="git pull"
alias gst="git status"
alias mac_flushdns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
alias macdns="scutil --dns | egrep -i '(domain|nameserver)'"
alias maclaunchrebuild="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias macncdu="ncdu --exclude /System/Volumes/Data -x /"
alias reset_xcode_previews="xcrun simctl --set previews delete all"
alias rclone="rclone -P"
alias telepresence_reconnect="telepresence quit && sleep 2 && telepresence connect"
alias tf="terraform"

# K8s
alias k='kubectl'
alias kd='kubectl describe'
alias kg='kubectl get'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias ke='kubectl exec'
alias kgn='kubectl get nodes'
alias kgns='kubectl get namespaces'

alias kda='kubectl describe --all-namespaces'
alias kga='kubectl get --all-namespaces'

alias kgp='kubectl get pod'
alias kdp='kubectl describe pod'
alias kgd='kubectl get deployment'
alias kdd='kubectl describe deployment'
alias kgs='kubectl get service'

alias kgpa='kubectl get pod --all-namespaces'
alias kgda='kubectl get deployment --all-namespaces'
alias kgsa='kubectl get svc --all-namespaces'

alias kcuc='kubectl config use-context'
alias kcur='kubectl config current-context'

# Columns for piping
# Example: cat test.txt | c2 | xargs echo
alias c1="awk '{print \$1}'"
alias c2="awk '{print \$2}'"
alias c3="awk '{print \$3}'"
alias c4="awk '{print \$4}'"
alias c5="awk '{print \$5}'"
alias c6="awk '{print \$6}'"
alias c7="awk '{print \$7}'"
alias c8="awk '{print \$8}'"
alias c9="awk '{print \$9}'"

alias ...="../../"
alias ....="../../../"
alias .....="../../../../"

source $ZDOTDIR/plugins/zsh-z/zsh-z.plugin.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

. ~/.local/bin/polyglot.sh
eval "$(direnv hook zsh)"

# Additional completions
source <(kubectl completion zsh)

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# Kukareku!
# vim:foldmethod=marker
