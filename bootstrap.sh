#!/usr/bin/env bash

set -ex

./install_dotfiles
./install_base_packages
[ ! -z "$XDG_SESSION_DESKTOP" ] && ./install_desktop
[ ! -d ~/.credentials ] && ./optional/setup_credentials
