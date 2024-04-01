set -ex

brew update
brew upgrade
brew cleanup

nvim --headless "+Lazy! sync" +qa
