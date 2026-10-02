export EDITOR=nvim

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.local/cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="$HOME/.local/runtime"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSHZ_DATA="$XDG_CONFIG_HOME/zsh/.zdata"
export HISTFILE="$XDG_DATA_HOME/history"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export UV_ENV_FILE=.env

export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"

export KUBECONFIG="$XDG_CONFIG_HOME/kube/config"
export KUBECACHEDIR="$XDG_CACHE_HOME/kube"
export PODMAN_COMPOSE_WARNING_LOGS=false

export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export B2_ACCOUNT_INFO="$XDG_CONFIG_HOME/b2_account_info"
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export KODI_DATA="$XDG_DATA_HOME/kodi"
export MBSYNCRC="$XDG_CONFIG_HOME/mbsync/config"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export UNISON="$XDG_DATA_HOME/unison"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"

export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export LESSHISTFILE=-
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude=.git || fdfind --type f --hidden --exclude=.git'
export FZF_DEFAULT_OPTS="--inline-info --preview 'bat {}'"

typeset -U path
[[ -d /opt/homebrew/bin ]] &&
    path=("/opt/homebrew/bin" $path)

[[ -d /home/linuxbrew/.linuxbrew/bin ]] &&
    path=("/home/linuxbrew/.linuxbrew/bin" $path)

path=(
    "$GOPATH/bin"
    "$HOME/.local/bin"
    "$HOME/.config/userscripts"
    "$HOME/.rd/bin"
    "/opt/homebrew/opt/postgresql@18/bin"
    "/opt/homebrew/share/google-cloud-sdk/bin"
    "$ANDROID_HOME/emulator"
    "$ANDROID_HOME/platform-tools"
    $path
)

# Bitwarden SSH agent (App Store)
BW_SOCK="$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
[[ -S "$BW_SOCK" ]] && export SSH_AUTH_SOCK="$BW_SOCK"
unset BW_SOCK
