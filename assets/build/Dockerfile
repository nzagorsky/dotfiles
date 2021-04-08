FROM ubuntu:20.10

ARG UNAME=developer
ARG UID=1000
ARG GID=1000


RUN apt-get update && \
    apt-get install -y stow git sudo zsh && \
    echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    groupadd -g $GID -o $UNAME && \
    useradd -m -u $UID -g $GID -o -s /bin/zsh $UNAME


USER $UNAME
WORKDIR /home/$UNAME/dotfiles
COPY . .
RUN ./install_dotfiles && \
    ./install_base_packages

CMD /bin/zsh
