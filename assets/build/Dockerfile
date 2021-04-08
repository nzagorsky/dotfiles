FROM ubuntu:20.10

WORKDIR /dotfiles
COPY . .
RUN apt-get update && \
    apt-get install -y stow git sudo  &&  \
    ./install_dotfiles && \
    ./install_base_packages

WORKDIR /workspace
