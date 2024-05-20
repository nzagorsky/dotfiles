set -ex

git fetch
git merge origin/master

if ! command -v brew &> /dev/null
then
    echo "no brew"
else
	brew update
	brew upgrade
	brew cleanup
fi

./install.sh

nvim --headless "+Lazy! restore" +qa
nvim --headless "+TSUpdateSync" +qa
