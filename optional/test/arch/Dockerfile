FROM base/archlinux

RUN pacman -Syy && pacman -S git --noconfirm
RUN git clone https://github.com/nzagorsky/dotfiles.git && ./dotfiles/install
