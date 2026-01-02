function t {
    launch_param=$(pidof systemd >/dev/null 2>&1 && echo "systemd-run --scope --user" || echo "")

    if [ -z "$argv" ]; then
        tmux -u attach -t default || zsh -c "$launch_param tmux -u new -s default 2> /dev/null"
    else
        tmux -u attach -t $@ || zsh -c "$launch_param tmux -u new -s $@ 2> /dev/null"
    fi
}

function limarecreate {
    limactl stop default
    limactl delete default
    limactl create --name=default ~/dotfiles/optional/lima/default.yaml
    limactl start default
}

function k_force_delete_ns {
    NAMESPACE=$1
    kubectl proxy &
    kubectl get namespace $NAMESPACE -o json | jq '.spec = {"finalizers":[]}' >temp.json
    curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
    rm temp.json
}

function extract() {
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

function macnst() {
    netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|"
}

function macnotify() {
    # Usage:
    # $ macnotify Title "Long notification text"

    osascript -e 'display notification "'$2'" with title "'$1'"'
}

function openwin() {
    osascript -e "tell application \"$1\" to activate" -e 'tell application "System Events" to keystroke "n" using command down'
}

function aiwebui() {
    mkdir -p ~/.local/share/webui
    cd ~/.local/share/webui
    mise use python@3.11
    pip3 install uv
    uvx open-webui serve
}

function dbibackend() {
    brew install libusb || true
    /opt/homebrew/bin/python3 -m pip install pyusb --break-system-packages
    /opt/homebrew/bin/python3 $HOME/Documents/Archive/old/legacy/dbibackend
}

function bwsecrets() {
    if ! bw login --check >/dev/null; then
        export BW_SESSION="$(bw login --raw)"
    fi

    if ! bw unlock --check >/dev/null; then
        export BW_SESSION="$(bw unlock --raw)"
    fi

    bw sync

    source <(bw get item "credentials.secure" | jq -r '.notes')
}

function ccurl() {
    curl -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
        -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7" \
        -H "Accept-Language: en-US,en;q=0.9" \
        -H "Connection: keep-alive" \
        -L \
        --compressed \
        --cookie-jar /tmp/cookies.txt \
        $@
}
