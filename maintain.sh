set -ex

git fetch
git merge origin/master

brew update
brew upgrade
brew cleanup

nvim --headless "+Lazy! sync" +qa
