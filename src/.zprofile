
export EDITOR=nvim

export ZDOTDIR="$HOME/.config/zsh"
export ZSHZ_DATA="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zdata"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.local/cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="$HOME/.local/runtime"

export UV_ENV_FILE=.env
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude=.git || fdfind --type f --hidden --exclude=.git'
export FZF_DEFAULT_OPTS="--inline-info --preview 'bat {}'"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export KUBECONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/kube/config"
export KUBECACHEDIR="$XDG_CACHE_HOME/kube"
export B2_ACCOUNT_INFO="${XDG_CONFIG_HOME:-$HOME/.config}/b2_account_info"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export LESSHISTFILE="-"
export PODMAN_COMPOSE_WARNING_LOGS=false
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/aws/config"
export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}/ipython"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export UNISON="${XDG_DATA_HOME:-$HOME/.local/share}/unison"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export MBSYNCRC="${XDG_CONFIG_HOME:-$HOME/.config}/mbsync/config"
export ELECTRUMDIR="${XDG_DATA_HOME:-$HOME/.local/share}/electrum"


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


# App store Bitwarden version
BW_SOCK="$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
[[ -S "$BW_SOCK" ]] && export SSH_AUTH_SOCK="$BW_SOCK"

