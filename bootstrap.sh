#!/usr/bin/env bash

./install_dotfiles
./install_base_packages
./install_desktop
[ ! -d "~/.credentials" ] && ./optional/setup_credentials
