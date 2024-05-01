
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZSHZ_DATA="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zdata"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc"
export XAUTHORITY="${XDG_CONFIG_HOME:-$HOME/.config}/X11/Xauthority"

export KUBECONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/kube/config"
export B2_ACCOUNT_INFO="${XDG_CONFIG_HOME:-$HOME/.config}/b2_account_info"

export LESSHISTFILE="-"
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

# Other program settings:
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export AWT_TOOLKIT="MToolkit wmname LG3D"	#May have to install wmname
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm

eval "$(/opt/homebrew/bin/brew shellenv)"  2>/dev/null
# export PATH="/opt/homebrew/bin:$PATH"
# export PATH="/opt/homebrew/sbin:$PATH"
# export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
# export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"

# Go
export PATH="$PATH:$GOPATH/bin"

export PATH="$PATH:$HOME/.krew/bin"

export PATH="$PATH:/opt/homebrew/opt/libpq/bin"

# Binary paths
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/userscripts"
export PATH="$PATH:$HOME/.local/include/cargo/bin"
export PATH="$PATH:$HOME/.local/share/cargo/bin"

export PATH="$PATH:$HOME/.yarn/bin"

# FZF config
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude=.git || fdfind --type f --hidden --exclude=.git'
export FZF_DEFAULT_OPTS="--inline-info --preview 'bat {}'"

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export LIBRARY_PATH="$LIBRARY_PATH:/opt/homebrew/opt/openssl@3/lib/"
