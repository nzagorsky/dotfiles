set -ex

git fetch
git merge origin/master

brew update
brew upgrade
brew cleanup

./install.sh

nvim --headless "+Lazy! sync" +qa
