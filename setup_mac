#!/usr/bin/env zsh


RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m'

cat ~/.zshrc | grep PATH > /tmp/dotenv && source /tmp/dotenv

set -ex

install_lf() {
    command -v lf > /dev/null && return 0
    env CGO_ENABLED=0 GO111MODULE=on go get -u -ldflags="-s -w" github.com/gokcehan/lf
}

set_defaults() {
    # Command + Ctrl window movement
    defaults write -g NSWindowShouldDragOnGesture -bool true

    # Keep spaces arrangement
    defaults write com.apple.dock "mru-spaces" -bool "false"

    # Reduce motion to avoid sliding animations on desktop switch
    defaults write com.apple.universalaccess reduceMotion -bool true

    # Finder: show hidden files by default
    defaults write com.apple.Finder AppleShowAllFiles -bool true

    # Enable spring loading for directories
    defaults write NSGlobalDomain com.apple.springing.enabled -bool true

    # Remove the spring loading delay for directories
    defaults write NSGlobalDomain com.apple.springing.delay -float 0

    # Speed up Mission Control animations # TODO: confirm if it still works on Big Sur
    defaults write com.apple.dock expose-animation-duration -float 0.1

    # Always show scrollbar
    defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

    # Save to disk (not to iCloud) by default
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
    
    # Disable the "Are you sure you want to open this application?" dialog
    # defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Speed up keyboard
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    defaults write -g ApplePressAndHoldEnabled -bool false

    # Enable subpixel font rendering on non-Apple LCDs
    # Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
    defaults write NSGlobalDomain AppleFontSmoothing -int 1

    # Finder: show path bar
    defaults write com.apple.finder ShowPathbar -bool true

    # Display full POSIX path as Finder window title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

    # Keep folders on top when sorting by name
    defaults write com.apple.finder _FXSortFoldersFirst -bool true

    # When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Avoid creating .DS_Store files on network or USB volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # Dock: Change minimize/maximize window effect
    defaults write com.apple.dock mineffect -string "scale"
    # Dock: Minimize windows into their application's icon
    defaults write com.apple.dock minimize-to-application -bool true
    # Dock: Remove the auto-hiding Dock delay
    defaults write com.apple.dock autohide-delay -float 0
    # Dock: Remove the animation when hiding/showing the Dock
    defaults write com.apple.dock autohide-time-modifier -float 0
    # Dock: Automatically hide and show the Dock
    defaults write com.apple.dock autohide -bool true
    # Dock: Don't show recent applications in Dock
    defaults write com.apple.dock show-recents -bool false

    # Hot corners
    # Possible values:
    #  0: no-op
    #  2: Mission Control
    #  3: Show application windows
    #  4: Desktop
    #  5: Start screen saver
    #  6: Disable screen saver
    #  7: Dashboard
    # 10: Put display to sleep
    # 11: Launchpad
    # 12: Notification Center
    # 13: Lock Screen

    # Top left screen corner > Mission Control
    defaults write com.apple.dock wvous-tl-corner -int 2
    defaults write com.apple.dock wvous-tl-modifier -int 0
    # Top right screen corner > Desktop
    defaults write com.apple.dock wvous-tr-corner -int 4
    defaults write com.apple.dock wvous-tr-modifier -int 0
    # Bottom left screen corner > Start screen saver
    # defaults write com.apple.dock wvous-bl-corner -int 5
    # defaults write com.apple.dock wvous-bl-modifier -int 0

    # Show all processes in Activity Monitor
    defaults write com.apple.ActivityMonitor ShowCategory -int 0

}

rust_setup() {
    rustup-init -y --default-toolchain stable
    rustup target add armv7-unknown-linux-gnueabihf
}

install_neovim_plugins() {
    nvim test.py --headless +UpdateRemotePlugins +q > /dev/null 2>&1
    echo -e "${BOLD}neovim install success${NC}"
}

install_npm_deps () {
    npm install -g --quiet --silent @bitwarden/cli > /dev/null 2>&1
    npm install -g --quiet --silent \
        neovim \
        bash-language-server \
        dockerfile-language-server-nodejs \
        elasticdump \
        javascript-typescript-langserver \
        marked \
        prettier \
        pyright \
        standard > /dev/null 2>&1 \
        && echo -e "${BOLD}npm install success${NC}"
    }

install_python_deps() {
    pip3 install -U --user \
        "python-language-server[all]" \
        awscli \
        bandit \
        black \
        mkenv \
        boto3 \
        bpytop \
        dataset \
        dateparser \
        django-stubs \
        "django<3" \
        docker-compose \
        flake8 \
        flake8-polyfill \
        ipdb \
        ipython \
        iredis \
        jedi \
        litecli \
        smart-open \
        neovim \
        nptime \
        pgcli \
        pipenv \
        saws \
        pulumi \
        pulumi-kubernetes \
        pulumi-aws \
        pulumi-hcloud \
        pydocstyle \
        pyflakes \
        python-dateutil \
        radon \
        requests \
        selenium \
        youtube-dl \
        vim-vint \
        yamllint \
        --no-warn-script-location \
        && echo -e "${BOLD}pip install success${NC}"
    }


install_brew_packages() {
    brew tap homebrew/cask-fonts

    brew install --cask easy-move-plus-resize
    brew install --cask chromedriver --no-quarantine
    brew install --cask insomnia

    # brew install --cask karabiner-elements
    # brew install yqrashawn/goku/goku
    # brew services start goku

    brew install \
        arm-linux-gnueabihf-binutils \
        bat \
        font-dejavu \
        universal-ctags \
        alt-tab \
        exa \
        fd \
        dbeaver-community \
        go \
        htop \
        wireguard-tools \
        watch \
        jq \
        kubectl \
        postgresql \
        mosh \
        mysql \
        neovim \
        libxmlsec1 \
        node \
        ncdu \
        parallel \
        pulumi \
        openvpn \
        python3 \
        rclone \
        ripgrep \
        rustup-init \
        sqlite3 \
        tmux \
        wget \
        zsh-syntax-highlighting \
        curl \
    && echo -e "${BOLD}Brew install success${NC}"
}

main() {
    set_defaults
    install_brew_packages
    rust_setup

    install_npm_deps
    install_python_deps
    install_neovim_plugins
    install_lf

    # Fix insecure directories
    # sudo chmod -R 755 /usr/local/share/zsh; sudo chown -R root:staff /usr/local/share/zsh
    sudo chown -R $(whoami) /usr/local/share/zsh /usr/local/share/zsh/site-functions

}

main
