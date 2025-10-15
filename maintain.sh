set -ex

git fetch
git merge origin/master

if ! command -v brew &>/dev/null; then
    echo "Brew was not found, consider installing it"
else
    brew bundle install
    brew upgrade
    brew cleanup
fi

./install.sh

nvim --headless "+Lazy! restore" +qa
nvim --headless "+TSUpdateSync" +qa
nvim --headless "+MasonUpdate" +qa
