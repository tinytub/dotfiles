#!/usr/bin/env bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles."

source install/link.sh

#source install/git.sh
source install/dep.sh

# only perform macOS-specific install
if [ "$(uname)" == "Darwin" ]; then
    echo -e "\\n\\nRunning on macOS"
    source install/brew.sh
    source install/osx.sh
fi
if [ "$(uname)" == "Linux" ]; then
    echo -e "\\n\\nRunning on Linux"
    source install/linux.sh
fi

source install/venv.sh
#
#echo "creating vim directories"
#mkdir -p ~/.vim-tmp
#
sh -c "$(curl -fsSL https://git.io/zinit-install)"
if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s "$(command -v zsh)"
fi

#echo "run: nvim -u init.vim -c 'call dein#recache_runtimepath()|q' to finish install vim plugins"
echo "run: nvim +PackerSync"

echo "Done. Reload your terminal."
