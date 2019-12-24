#!/usr/bin/env bash

echo -e "\\n\\nRunning Neovim Python install"
echo "=============================="

# Declare a base path for both virtual environments
venv="${XDG_CACHE_HOME:-$HOME/.cache}/vim/venv"

if [ ! -d "$venv" ]; then
    echo "Creating $venv"
    mkdir -p "$venv"
fi


# Try to detect python2/3 executables
if ! hash python2 2>/dev/null; then
    echo "Python2 installation not found."
    exit 1
elif ! hash python3 2>/dev/null; then
    echo "Python3 installation not found."
    exit 1
fi

# Ensure python 2/3 virtual environments
[ -d "$venv" ] || mkdir -p "$venv"
[ -d "$venv/neovim2" ] || python2 -m virtualenv "$venv/neovim2"
[ -d "$venv/neovim3" ] || python3 -m venv "$venv/neovim3"

# Install or upgrade dependencies
echo ':: PYTHON 2'
"$venv/neovim2/bin/pip" install -U neovim PyYAML pynvim
echo -e '\n:: PYTHON 3'
"$venv/neovim3/bin/pip" install -U neovim PyYAML pynvim
