#!/bin/sh

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install latest nodejs
if ! command -v node > /dev/null; then
  curl --fail -L https://install-node.now.sh/latest | sh
  # Or use apt-get
  # sudo apt-get install nodejs
fi

# Install yarn
if ! command -v yarn > /dev/null; then
  curl --fail -L https://yarnpkg.com/install.sh | sh
fi

#ln -sf ~/vim/coc-settings.json ~/.vim/coc-settings.json
