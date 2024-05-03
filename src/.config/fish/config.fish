# https://fishshell.com/docs/current/faq.html
# This is equal to .profile
if status is-interactive
    set fish_greeting

    set -x GOPATH "$HOME/.local/share/go"
    set -x PYENV_ROOT "$HOME/.pyenv"

    fish_add_path $GOPATH/bin
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/sbin
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.local/include/cargo/bin
    fish_add_path $HOME/.yarn/bin
    fish_add_path $HOME/.local/share/cargo/bin
    fish_add_path $PYENV_ROOT/bin

    # FZF config
    set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude=.git || fdfind --type f --hidden --exclude=.git'
    set -x FZF_DEFAULT_OPTS "--inline-info --preview 'bat --color=always --style plain --theme Nord {}'"

    set -x NVIM_LISTEN_ADDRESS /tmp/nvimsocket


    set -x ZDOTDIR "$HOME/.config/zsh"
    set -x ZSHZ_DATA "$HOME/.config/zsh/.zdata"

    set -x XDG_CONFIG_HOME "$HOME/.config"
    set -x XDG_DATA_HOME "$HOME/.local/share"
    set -x XDG_CACHE_HOME "$HOME/.cache"
    set -x XINITRC "$HOME/.config/X11/xinitrc"
    set -x XAUTHORITY "$HOME/.config/X11/Xauthority"

    set -x KUBECONFIG "$HOME/.config/kube/config"
    set -x B2_ACCOUNT_INFO "$HOME/.config/b2_account_info"

    set -x LESSHISTFILE "-"
    set -x GNUPGHOME "$HOME/.config/gnupg"
    set -x WGETRC "$HOME/.config/wget/wgetrc"
    set -x AWS_CONFIG_FILE "$HOME/.config/aws/config"
    set -x IPYTHONDIR "$HOME/.config/ipython"
    set -x INPUTRC "$HOME/.config/shell/inputrc"
    set -x WINEPREFIX "$HOME/.local/share/wineprefixes/default"
    set -x KODI_DATA "$HOME/.local/share/kodi"
    set -x PASSWORD_STORE_DIR "$HOME/.local/share/password-store"
    set -x TMUX_TMPDIR "$XDG_RUNTIME_DIR"
    set -x ANDROID_SDK_HOME "$HOME/.config/android"
    set -x CARGO_HOME "$HOME/.local/share/cargo"
    set -x ANSIBLE_CONFIG "$HOME/.config/ansible/ansible.cfg"
    set -x UNISON "$HOME/.local/share/unison"
    set -x HISTFILE "$HOME/.local/share/history"
    set -x MBSYNCRC "$HOME/.config/mbsync/config"
    set -x ELECTRUMDIR "$HOME/.local/share/electrum"
end



source ~/.config/credentials/secure > /dev/null 2>&1 || true

# set -x TERM xterm-256color
set -x BROWSER open
set -x EDITOR nvim
set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

set -x ANSIBLE_HOST_KEY_CHECKING False
set -x ANSIBLE_PIPELINING True

alias g=git
alias v=nvim
alias p=ipython

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


alias gpull="git pull"
alias gst="git status"

alias lofimpv='mpv --no-video "https://www.youtube.com/watch?v=jfKfPfyJRdk"'
alias wowmpv='mpv --no-video "https://www.youtube.com/Meisio/live"'


function kconfig
    set -x KUBECONFIG "$HOME/.config/kube/$argv"
end

function macnotify 
    # Usage: $ macnotify Title "Long notification text"
    osascript -e 'display notification "'$2'" with title "'$1'"'
end

function tmux_attach
    if test -z "$argv"
        set processList $(ps x | grep "tmux -L")
        set sessionName $(string match -rg --  '-L\s+(\S+)' $processList |  string replace -r -- '-L\s+(\S+)' '$1' | fzf)

        if test -z "$sessionName"
            echo "Empty picker"
            return
        end

        echo Picked: $sessionName
        tmux -L $sessionName attach -t $sessionName
    else
        tmux -L $argv attach -t $argv ; or zsh -c "tmux -L $argv new -s $argv  2> /dev/null"
    end
end

function t
    FZF_DEFAULT_OPTS="--preview 'tmux -L {} lsw'" tmux_attach $argv
end

eval "$(pyenv init -)"
