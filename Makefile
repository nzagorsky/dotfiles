dotfiles:
	./install_dotfiles

base: dotfiles
	./install_base_packages

desktop: base
	./install_desktop

bootstrap: 
	./install_dotfiles
	./install_base_packages
	[ ! -z "$$XDG_SESSION_DESKTOP" ] && ./install_desktop
	[ ! -d ~/.credentials ] && ./optional/setup_credentials

build:
	docker build -t devenv -f assets/build/Dockerfile .
