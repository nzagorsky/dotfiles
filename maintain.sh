set -ex

git fetch
git merge origin/master

if type brew &>/dev/null; then
	brew update
	brew upgrade
	brew cleanup
fi

./install.sh

nvim --headless "+Lazy! sync" +qa
