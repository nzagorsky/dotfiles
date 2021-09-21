# Arch setup

set -e

GNOME_EXTENSION_INSTALLER=~/.local/bin/gnome-shell-extension-installer

bspwm() {
    sudo pacman -S --needed --noconfirm \
        sxhkd \
        bspwm \
        gnome-keyring \
        pavucontrol \
        blueman \
        xcompmgr \
        dunst \
        dmenu \
        nitrogen \
        xdotool
}

setup_yay() {
    command -v yay > /dev/null && return 0
    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
}

install_npm_deps () {
    sudo npm install -g --quiet --silent @bitwarden/cli > /dev/null 2>&1
    sudo npm install -g --quiet --silent \
        neovim \
        bash-language-server \
        dockerfile-language-server-nodejs \
        javascript-typescript-langserver \
        prettier \
        pyright \
        standard > /dev/null 2>&1 \
    && echo -e "${BOLD}npm install success${NC}"
}

install_python_deps() {
    pip install -U --user setuptools wheel --no-warn-script-location

    pip install -U --user \
        "python-language-server[all]" \
        awscli \
        black \
        psycopg2 \
        smart-open \
        boto3 \
        dateparser \
        django-stubs \
        "django<3" \
        ipdb \
        ipython \
        saws \
        neovim \
        requests \
        selenium \
        youtube-dl \
        vim-vint \
        yamllint \
        --no-warn-script-location \
        && echo -e "${BOLD}pip install success${NC}"
}

setup_base() {
    sudo pacman -S --needed --noconfirm \
        bat \
        duplicity \
        ctags \
        sshpass \
        postgresql-libs \
        mariadb-clients \
        curl \
        python-pip \
        xmlsec \
        docker \
        docker-compose \
        exa \
        fd \
        fzf \
        git \
        go \
        htop \
        httpie \
        jq \
        lm_sensors \
        neovim \
        npm \
        openvpn \
        rclone \
        ripgrep \
        rustup \
        sqlite3 \
        stow \
        stress \
        tmux \
        unzip \
        wget \
        zip \
        zsh

    sudo sed -i '/PasswordAuthentication/c\PasswordAuthentication no' /etc/ssh/sshd_config
}

install_neovim_plugins() {
    nvim test.py --headless +UpdateRemotePlugins +q > /dev/null 2>&1
    echo -e "${BOLD}neovim install success${NC}"
}

configure_shell() {

    sudo chsh $(whoami) -s $(which zsh)
}

setup_media() {
    command -v ffmpegthumbnailer > /dev/null && return 0

    sudo pacman -S --needed --noconfirm ffmpegthumbnailer gst-plugins-ugly
    rm -rf .cache/thumbnails/fail/gnome-thumbnail-factory/*
    rm -rf .cache/thumbnails/large/*
    rm -rf ~/.cache/gstreamer-1.0/*
    nautilus -q

}

setup_desktop() {
    sudo pacman -S --needed --noconfirm \
        alacritty \
        lutris \
        bluez-utils \
        ttf-dejavu \
        qbittorrent \
        docker \
        networkmanager \
        networkmanager-openvpn \
        xclip \
        telegram-desktop \
        mpv

    yay -S --needed --noconfirm \
        brave-bin \
        toptracker \
        google-chrome \
        fondo \
        obsidian \
        megasync \
        mailspring

    sudo systemctl enable docker --now
    sudo gpasswd -a $USER docker
}

install_chromedriver() {
    set -e
    CHROMEDRIVER_RELEASE=$(curl -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
    wget -q "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_RELEASE/chromedriver_linux64.zip" -O /tmp/chromedriver.zip
    rm -rf /tmp/chromedriver/
    mkdir /tmp/chromedriver/
    unzip -qq /tmp/chromedriver.zip -d /tmp/chromedriver/
    chmod +x /tmp/chromedriver/chromedriver
    sudo install /tmp/chromedriver/chromedriver /usr/local/bin/chromedriver
    rm -rf /tmp/chromedriver/
}

install_gnome_extension() {
    extension_name=$1
    extension_id=$2
    gnome-extensions list | grep $extension_name > /dev/null  || $GNOME_EXTENSION_INSTALLER --yes $extension_id; gnome-extensions enable $extension_name
}

configure_gnome () {
    # Put dconf settings in
    dconf load  / < assets/gnome/dconf.conf
    gsettings set org.gnome.shell.app-switcher current-workspace-only true
    gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 20
    gsettings set org.gnome.desktop.peripherals.keyboard delay 200
    gsettings set org.gnome.desktop.default-applications.terminal exec alacritty

    $GNOME_EXTENSION_INSTALLER --update

    # Do not install extensions if they are installed already.
    gnome-extensions info -q bluetooth-quick-connect@bjarosze.gmail.com > /dev/null && return

    # Install and enable required extensions
    install_gnome_extension appindicatorsupport@rgcjonas.gmail.com 615  # KStatusNotifierItem
    install_gnome_extension bluetooth-quick-connect@bjarosze.gmail.com 1401  # Bluetooth quick connect
    install_gnome_extension impatience@gfxmonk.net 277  # Faster animations
    install_gnome_extension user-theme@gnome-shell-extensions.gcampax.github.com 19  # Shell themes

    curl -sL https://github.com/windsorschmidt/disable-workspace-switcher-popup/tarball/master |
      tar xzv --wildcards --strip 1 --directory ~/.local/share/gnome-shell/extensions/ \
      "*/disable-workspace-switcher-popup@github.com"

    curl -sL https://github.com/nzagorsky/audio-switcher/tarball/master |
      tar xzv --wildcards --strip 1 --directory ~/.local/share/gnome-shell/extensions/ \
      "*/audio-switcher@github.com"
}


main () {
    setup_yay
    setup_base

    setup_desktop
    setup_media
    install_chromedriver

    install_npm_deps
    install_python_deps
    install_neovim_plugins
    configure_shell
    configure_gnome
}


main
